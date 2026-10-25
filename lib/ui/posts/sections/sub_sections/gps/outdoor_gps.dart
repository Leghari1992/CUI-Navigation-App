import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class GPSScreen extends StatefulWidget {
  const GPSScreen({super.key});
  @override
  State<GPSScreen> createState() => _GPSScreenState();
}

class _GPSScreenState extends State<GPSScreen> {
  final List<Map<String, dynamic>> _markerData = [
    {"id": "1", "lat": 33.652415, "lng": 73.157104, "title": "Comsats Gate 1"},
    {"id": "2", "lat": 33.652010, "lng": 73.157810, "title": "Comsats Gate 2"},
    {"id": "3", "lat": 33.647725, "lng": 73.157498, "title": "Comsats Gate 3"},
    {"id": "4", "lat": 33.651854, "lng": 73.156207, "title": "Mosque"},

    {"id": "5", "lat": 33.651118, "lng": 73.156242, "title": "Academic Block -I"},
    {"id": "6", "lat": 33.650215, "lng": 73.155598, "title": "Academic Block -II"},
    {"id": "7", "lat": 33.648054, "lng": 73.155965, "title": "Academic Block -III"},

    {"id": "8", "lat": 33.650734, "lng": 73.155766, "title": "Physics Block"},

    {"id": "9", "lat": 33.649621, "lng": 73.155304, "title": "Faculty Block -I"},
    {"id": "10", "lat": 33.649183, "lng": 73.155531, "title": "Faculty Block -II"},

    {"id": "11", "lat": 33.648705, "lng": 73.154368, "title": "N-Block"},
    {"id": "12", "lat": 33.649450, "lng": 73.154665, "title": "Library"},

    {"id": "13", "lat": 33.648643, "lng": 73.155175, "title": "Student Services Center/Main Cafe"},
    {"id": "14", "lat": 33.651936, "lng": 73.157437, "title": "Sitting Area 1"},
    {"id": "15", "lat": 33.650980, "lng": 73.155171, "title": "Sitting Area 2"},
    {"id": "16", "lat": 33.648259, "lng": 73.155565, "title": "Sitting Area 3"},
    {"id": "17", "lat": 33.648846, "lng": 73.154738, "title": "Sitting Area 4"},

    {"id": "18", "lat": 33.647574, "lng": 73.157410, "title": "Bus Parking"},
    {"id": "19", "lat": 33.648683, "lng": 73.155813, "title": "Transport Office"},
    {"id": "20", "lat": 33.648858, "lng": 73.155679, "title": "Medical Center"},


    {"id": "21", "lat": 33.647941, "lng": 73.156671, "title": "SSBC"},
    {"id": "22", "lat": 33.647782, "lng": 73.156829, "title": "R & D Lab"},

    {"id": "23", "lat": 33.647629, "lng": 73.156099, "title": "Tennis Court"},
    {"id": "24", "lat": 33.647461, "lng": 73.156267, "title": "Badminton Court"},
    {"id": "25", "lat": 33.647211, "lng": 73.156232, "title": "Basketball Court"},
    {"id": "26", "lat": 33.646927, "lng": 73.157074, "title": "Cricket Ground"},

    {"id": "27", "lat": 33.649433, "lng": 73.156087, "title": "Generator Room"},
    {"id": "28", "lat": 33.650374, "lng": 73.156786, "title": "Glass Room"},
    {"id": "29", "lat": 33.650729, "lng": 73.157006, "title": "Nano Lab"},


    {"id": "30", "lat": 33.651650, "lng": 73.157766, "title": "HT Panel Room"},
    {"id": "31", "lat": 33.650840, "lng": 73.154522, "title": "Faculty Parking 1"},
    {"id": "32", "lat": 33.648937, "lng": 73.154275, "title": "Faculty Parking 2"},
    {"id": "33", "lat": 33.648355, "lng": 73.155930, "title": "Faculty Parking 3"},
  ];

  Future<void> _launchMapsUrl(double lat, double lng) async {
    final Uri url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=walking');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _checkLocationService() async {
    BuildContext context = this.context; // Capture the context
    bool serviceEnabled;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show a dialog to enable location
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Location Services Disabled"),
          content: const Text("Please enable location services to use this feature."),
          actions: [
            TextButton(
              child: const Text("No thanks"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the page
              },
            ),
            TextButton(
              child: const Text("Turn on"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  // Navigate to location settings
                  await Geolocator.openLocationSettings();
                }
              },
            ),
          ],
        ),
      );
    }
  }





  @override
  void initState() {
    super.initState();
    _checkLocationService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text("All Locations", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.indigo,
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Please select your desired location, and you will be directed to Google Maps for directions.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: ListTile(
                      leading: const Icon(Icons.directions, color: Colors.white),
                      title: Text(
                        _markerData[index]['title'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        double lat = _markerData[index]['lat'];
                        double lng = _markerData[index]['lng'];
                        _launchMapsUrl(lat, lng);
                      },
                    ),
                  ),
                );
              },
              childCount: _markerData.length,
            ),
          ),
        ],
      ),
    );
  }
}
