import 'package:again1/ui/posts/sections/sub_sections/gps/outdoor_gps.dart';
import 'package:flutter/material.dart';
import 'package:again1/ui/posts/sections/sub_sections/gps/indoor_gps/main.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Navigation Options", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Display the image at the top
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/gps.png', height: 250),
              ),
              // Welcome description

              // Welcome description
              // Welcome description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Welcome to the Navigation Options Page! Choose an option below to proceed.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),


              const SizedBox(height: 20),
              // Outdoor GPS button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GPSScreen()),
                  );
                },
                icon: Icon(Icons.gps_fixed),
                label: Text("Outdoor GPS", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16), // Adjust button size here
                  textStyle: TextStyle(fontSize: 18), // Adjust text size here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Indoor GPS button
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndoorGPSAppScreen()),
                  );
                  // Navigate to Indoor GPS screen
                },
                icon: Icon(Icons.gps_off),
                label: Text("Indoor GPS", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 16), // Adjust button size here
                  textStyle: TextStyle(fontSize: 18), // Adjust text size here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Maps button
              ElevatedButton.icon(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapsScreen()),
                  );
                  // Navigate to Maps screen
                },
                icon: Icon(Icons.map),
                label: Text("Map", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16), // Adjust button size here
                  textStyle: TextStyle(fontSize: 18), // Adjust text size here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MapsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Map', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        //   color: Colors.white, // Set a background color for the whole screen
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 15.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  // color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 150,
                    ),
                    //    Icon(Icons.school_outlined, size: 50, color: Colors.blue),
                    SizedBox(height: 10.0),
                    Text(
                      'Welcome to the COMSATS University Islamabad Map!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Below, you\'ll find a detailed map highlighting the various buildings across the campus. Use this map to navigate and locate specific buildings with ease. Whether you\'re a visitor, student, or staff member, this guide will help you find your way around the university.',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                padding: EdgeInsets.all(5),

                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  //  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(20.0),
                  minScale: 0.1,
                  maxScale: 2.0,
                  child: Image.asset(
                    //'assets/images/unimap.PNG',
                    'assets/images/map2.jpg',
                    height: 300, // Adjust height as needed
                  ),
                ),
              ),
              // Add the map widget here
            ],
          ),
        ),
      ),
    );
  }
}











