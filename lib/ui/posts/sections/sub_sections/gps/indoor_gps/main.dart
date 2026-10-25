import 'dart:convert';
import 'dart:math';
import 'NearbyBeaconsPage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'data.dart';
import 'locations.dart';

class IndoorGPSAppScreen extends StatefulWidget {
  const IndoorGPSAppScreen({super.key});

  @override
  State<IndoorGPSAppScreen> createState() => _IndoorGPSAppScreenState();
}

class _IndoorGPSAppScreenState extends State<IndoorGPSAppScreen> {
  late final WebViewController _controller;
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  String? _selectedStartLocation;
  String? _selectedEndLocation;
  List<double> _userPosition = [0, 0]; // Current user position
  String? _lastUserNode; // Last detected node

  // Position stabilization
  final List<List<double>> _positionBuffer = [];
  final int _bufferSize = 3; // Number of positions to average
  double _movementThreshold =
  0.5; // Minimum distance to consider actual movement

  // RSSI calibration
  static const double n = 2.0; // Path loss exponent (environment dependent)
  static const double txPower = -59; // RSSI at 1 meter (calibrated per beacon)

  // Scan settings
  static const int _scanDuration = 4; // Scan duration in seconds

  @override
  void initState() {
    super.initState();
    _controller =
    WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (url) {}))
      ..loadRequest(Uri.parse('https://leafleft-api.vercel.app/'));
  }

  Future<void> _scanBeacons() async {
    if (_selectedEndLocation == null) {
      Fluttertoast.showToast(
        msg: "Please select an end location",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    List<Map<String, dynamic>> scannedBeacons = [];
    Fluttertoast.showToast(
      msg: "Scanning for beacons...",
      toastLength: Toast.LENGTH_SHORT,
    );

    FlutterBluePlus.startScan(timeout: Duration(seconds: _scanDuration));
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        scannedBeacons.add({"Mac": r.device.id.toString(), "RSSI": r.rssi});
      }
      _sendPathToWebApp(scannedBeacons);
    });
    await Future.delayed(Duration(seconds: _scanDuration + 1));
  }

  void _sendPathToWebApp(List<Map<String, dynamic>> scannedBeacons) {
    if (_selectedEndLocation == null) return;

    // Update user position with stabilization
    List<double> rawPosition = _estimateUserPosition(scannedBeacons);
    _userPosition = _stabilizePosition(rawPosition);

    // Get start node
    String startNodeLabel;

    if (_userPosition[0] != 0 || _userPosition[1] != 0) {
      // Use position-based nearest node
      Map<String, dynamic> startNode;

      if (_selectedStartLocation != null) {
        // Use nearest node within selected location
        startNode = getNearestNodeInLocation(
          _selectedStartLocation!,
          _userPosition,
          nodes,
        );
      } else {
        // Use overall nearest node
        startNode = _getNearestNode(_userPosition);
      }

      if (startNode.isEmpty || startNode['label'] == null) {
        Fluttertoast.showToast(
          msg: "Cannot determine starting point",
          toastLength: Toast.LENGTH_SHORT,
        );
        return;
      }
      startNodeLabel = startNode['label'].toString();
      _lastUserNode = startNodeLabel;
    } else if (_selectedStartLocation != null) {
      // Fall back to selected location's first node
      Map<String, dynamic> startNode = getNodesForLocation(
        _selectedStartLocation!,
        nodes,
      ).firstWhere((node) => node['coordinates'] != null, orElse: () => {});

      if (startNode.isEmpty || startNode['label'] == null) {
        Fluttertoast.showToast(
          msg: "Invalid start location",
          toastLength: Toast.LENGTH_SHORT,
        );
        return;
      }
      startNodeLabel = startNode['label'].toString();
    } else if (_lastUserNode != null) {
      // Use last known node if available
      startNodeLabel = _lastUserNode!;
    } else {
      Fluttertoast.showToast(
        msg: "Please select a start location or use 'Locate Me' first",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    // Get end node based on location selection
    List<Map<String, dynamic>> endLocationNodes = getNodesForLocation(
      _selectedEndLocation!,
      nodes,
    );

    if (endLocationNodes.isEmpty) {
      Fluttertoast.showToast(
        msg: "No nodes found for selected end location",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    // Find nearest node in end location
    Map<String, dynamic> endNode = _findNearestNodeFromList(
      endLocationNodes,
      _userPosition,
    );

    if (endNode.isEmpty || endNode['label'] == null) {
      Fluttertoast.showToast(
        msg: "Cannot determine end point",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    String endNodeLabel = endNode['label'].toString();

    // Send path request to web app
    final message = jsonEncode({"start": startNodeLabel, "end": endNodeLabel});
    _controller.runJavaScript('window.postMessage($message, "*");');

    print("Path: $startNodeLabel to $endNodeLabel");
  }

  // Helper to find nearest node from a list of nodes
  Map<String, dynamic> _findNearestNodeFromList(
      List<Map<String, dynamic>> nodesList,
      List<double> position,
      ) {
    if (nodesList.isEmpty) return {};

    Map<String, dynamic> nearest = nodesList.firstWhere(
          (node) => node['coordinates'] != null,
      orElse: () => nodesList.isNotEmpty ? nodesList.first : {},
    );

    if (nearest.isEmpty) return {};

    // If position is unknown, just return the first valid node
    if (position[0] == 0 && position[1] == 0) {
      return nearest;
    }

    double? minDistance = double.infinity;

    for (var node in nodesList) {
      if (node['coordinates'] == null) continue;

      num distance = _calculateDistance(position, node['coordinates']);
      if (distance < minDistance!) {
        minDistance = distance as double?;
        nearest = node;
      }
    }

    return nearest;
  }

  void _sendUserPositionToWebApp(List<Map<String, dynamic>> scannedBeacons) {
    // Update user position with stabilization
    List<double> rawPosition = _estimateUserPosition(scannedBeacons);
    _userPosition = _stabilizePosition(rawPosition);

    if (_userPosition[0] == 0 && _userPosition[1] == 0) {
      Fluttertoast.showToast(
        msg: "Unable to determine position",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    Map<String, dynamic> nearestNode = _getNearestNode(_userPosition);
    if (nearestNode.isEmpty || nearestNode['label'] == null) {
      Fluttertoast.showToast(
        msg: "No nearby node found",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    String nodeLabel = nearestNode['label'].toString();
    _lastUserNode = nodeLabel; // Store for future use

    final message = jsonEncode({"userCoords": nodeLabel});
    _controller.runJavaScript('window.postMessage($message, "*");');

    // Show location info to user
    String locationName = _getLocationForNode(nodeLabel);
    Fluttertoast.showToast(
      msg: "You are near: $locationName",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  // Helper to stabilize position using moving average and threshold
  List<double> _stabilizePosition(List<double> newPosition) {
    // Return immediately if invalid position
    if (newPosition[0] == 0 && newPosition[1] == 0) {
      return _positionBuffer.isNotEmpty ? _positionBuffer.last : [0, 0];
    }

    // Initialize buffer if empty
    if (_positionBuffer.isEmpty) {
      for (int i = 0; i < _bufferSize; i++) {
        _positionBuffer.add(newPosition);
      }
      return newPosition;
    }

    // Calculate distance from last position
    List<double> lastPosition = _positionBuffer.last;
    double distance = sqrt(
      pow(newPosition[0] - lastPosition[0], 2) +
          pow(newPosition[1] - lastPosition[1], 2),
    );

    // If movement is below threshold, ignore it
    if (distance < _movementThreshold) {
      return lastPosition;
    }

    // Otherwise, add to buffer and calculate average
    _positionBuffer.add(newPosition);
    if (_positionBuffer.length > _bufferSize) {
      _positionBuffer.removeAt(0);
    }

    // Calculate weighted moving average
    double x = 0, y = 0;
    double totalWeight = 0;

    // More recent positions have higher weight
    for (int i = 0; i < _positionBuffer.length; i++) {
      double weight = (i + 1).toDouble(); // Linear weight increase
      x += _positionBuffer[i][0] * weight;
      y += _positionBuffer[i][1] * weight;
      totalWeight += weight;
    }

    return [x / totalWeight, y / totalWeight];
  }

  // Helper to find which location a node belongs to
  String _getLocationForNode(String nodeLabel) {
    for (var entry in locationNodes.entries) {
      if (entry.value.contains(nodeLabel)) {
        return entry.key;
      }
    }
    return "Unknown Location";
  }

  List<double> _estimateUserPosition(
      List<Map<String, dynamic>> scannedBeacons,
      ) {
    // Filter beacons and map to positions with distances
    List<Map> filteredBeacons =
    scannedBeacons
        .map((beacon) {
      var knownBeacon = beacons.firstWhere(
            (b) => b['mac'] == beacon['Mac'],
        orElse: () => {},
      );
      if (knownBeacon.isEmpty) return {};

      // Apply RSSI filtering to reduce outliers
      int rssi = beacon['RSSI'];
      if (rssi > -30) rssi = -30; // Cap extremely strong signals
      if (rssi < -90) rssi = -90; // Cap extremely weak signals

      return {
        "x": knownBeacon['coordinates'][0],
        "y": knownBeacon['coordinates'][1],
        "distance": _rssiToDistance(rssi),
      };
    })
        .where((b) => b.isNotEmpty)
        .toList();

    // Need at least 3 beacons for reliable trilateration
    if (filteredBeacons.length < 3) return [0, 0];

    // Apply weighted centroid algorithm
    double sumX = 0, sumY = 0, sumWeight = 0;

    for (var beacon in filteredBeacons) {
      // Inverse-square weighting - closer beacons have more influence
      double distance = beacon['distance'];
      double weight = 1 / (distance * distance);

      sumX += beacon['x'] * weight;
      sumY += beacon['y'] * weight;
      sumWeight += weight;
    }

    if (sumWeight == 0) return [0, 0];

    return [sumX / sumWeight, sumY / sumWeight];
  }

  double _rssiToDistance(int rssi) {
    // Apply environmental factor to reduce variability
    return pow(10, (txPower - rssi) / (10 * n)).toDouble();
  }

  // Helper to calculate distance between two points
  num _calculateDistance(List<double> point1, List<dynamic> point2) {
    return pow(point1[0] - point2[0], 2) + pow(point1[1] - point2[1], 2);
  }

  Map<String, dynamic> _getNearestNode(List<double> position) {
    if (nodes.isEmpty) return {};

    Map<String, dynamic> closest = nodes.firstWhere(
          (node) => node['coordinates'] != null,
      orElse: () => nodes.isNotEmpty ? nodes.first : {},
    );

    if (closest.isEmpty) return {};

    double? minDistance = double.infinity;

    for (var node in nodes) {
      if (node['coordinates'] == null) continue;

      num distance = _calculateDistance(position, node['coordinates']);
      if (distance < minDistance!) {
        minDistance = distance as double?;
        closest = node;
      }
    }

    return closest;
  }

  Future<void> _locateUser() async {
    bool isBluetoothOn =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    if (!isBluetoothOn) {
      Fluttertoast.showToast(
        msg: "Bluetooth is Off",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    List<Map<String, dynamic>> scannedBeacons = [];
    FlutterBluePlus.startScan(timeout: Duration(seconds: _scanDuration));

    Fluttertoast.showToast(
      msg: "Scanning for beacons...",
      toastLength: Toast.LENGTH_SHORT,
    );

    FlutterBluePlus.scanResults.listen((results) {
      if (results.isEmpty) {
        Fluttertoast.showToast(
          msg: "No BLE beacons found nearby",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        for (ScanResult r in results) {
          scannedBeacons.add({
            "Mac": r.device.remoteId.toString(),
            "RSSI": r.rssi,
          });
        }
        _sendUserPositionToWebApp(scannedBeacons);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get list of available locations
    List<String> locations = locationNodes.keys.toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('AB-I Ground Floor'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // This will pop the current page and go back
            },
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.wifi_tethering),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearbyBeaconsPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),

        body: Column(
          children: [
            Expanded(child: WebViewWidget(controller: _controller)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String?>(
                value: _selectedStartLocation,
                hint: const Text('Select Start Location (optional)'),
                onChanged:
                    (value) => setState(() => _selectedStartLocation = value),
                items: [
                  // Add "Current Location" option
                  DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Use Current Location'),
                  ),
                  // Add all defined locations
                  ...locations.map(
                        (location) => DropdownMenuItem<String?>(
                      value: location,
                      child: Text(location),
                    ),
                  ),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: _selectedEndLocation,
                hint: const Text('Select End Location'),
                onChanged:
                    (value) => setState(() => _selectedEndLocation = value),
                items:
                locations
                    .map(
                      (location) => DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  ),
                )
                    .toList(),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _scanBeacons,
                    icon: Icon(Icons.route),
                    label: const Text('Show Path'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _locateUser,
                    icon: Icon(Icons.my_location),
                    label: const Text('Locate Me'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
