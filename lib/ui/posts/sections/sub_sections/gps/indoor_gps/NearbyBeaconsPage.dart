import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // Use for BLE scanning

class NearbyBeaconsPage extends StatefulWidget {
  const NearbyBeaconsPage({super.key});

  @override
  _NearbyBeaconsPageState createState() => _NearbyBeaconsPageState();
}

class _NearbyBeaconsPageState extends State<NearbyBeaconsPage> {
  bool isScanning = false;
  List<BluetoothDevice> beacons = [];

  void scanForBeacons() async {
    setState(() {
      isScanning = true;
      beacons.clear();
    });

    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        beacons = results.map((r) => r.device).toList();
      });
    });

    await Future.delayed(Duration(seconds: 5)); // Simulating scan time
    setState(() {
      isScanning = false;
    });

    FlutterBluePlus.stopScan();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Nearby Beacons')),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20),
              Expanded(
                child:
                beacons.isEmpty && !isScanning
                    ? Center(child: Text('No beacons found'))
                    : ListView.builder(
                  itemCount: beacons.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        beacons[index].name.isNotEmpty
                            ? beacons[index].name
                            : 'Unknown Beacon',
                      ),
                      subtitle: Text(beacons[index].id.toString()),
                    );
                  },
                ),
              ),
            ],
          ),
          if (isScanning) Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isScanning ? null : scanForBeacons,
        child: Icon(Icons.bluetooth_searching),
      ),
    );
  }
}
