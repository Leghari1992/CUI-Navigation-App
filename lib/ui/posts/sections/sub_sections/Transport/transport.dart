import 'package:flutter/material.dart';
import 'routes.dart'; // Import the routes.dart file
import 'buses_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class Transport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transport', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/buses.jpg', // Replace with your image path
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'COMSATS University strives to enhance student comfort with comprehensive transport services. Students can avail paid transport at an economical cost each semester. The campus boasts a diverse fleet including buses, coasters, and vans covering various routes in Islamabad, Rawalpindi, and nearby areas. Efforts are underway to expand this fleet further, ensuring convenient commuting for students. A dedicated transport office facilitates easy access to these services.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '\u2022 Buses are situated near Gate-3 within the campus.\n'
                    '\u2022 The transport office is conveniently located beside the medical center.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/transportoffice.jpg', // Replace with your image path
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),

              Text(
                'For more details, please visit this website:',
                style: TextStyle(fontSize: 16.0, color:Colors.teal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 5.0),
              GestureDetector(
                onTap: () => _launchURL('https://www.comsats.edu.pk'),
                child: Text(
                  'https://www.comsats.edu.pk',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    //   decoration: TextDecoration.underline,
                  ),
                ),
              ),

              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ServicesProvidedScreen()),
                          );
                        },
                        icon: Icon(Icons.info, color: Colors.white),
                        label: Text('Services Provided', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RoutesScreen()),
                          );
                        },
                        icon: Icon(Icons.map, color: Colors.white),
                        label: Text('Routes', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50, // Adjust height as needed
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactsScreen()),
                          );
                        },
                        icon: Icon(Icons.contact_phone, color: Colors.white),
                        label: Text('Contacts', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      throw 'Could not launch $url: $e';
    }
  }
}

class ServicesProvidedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Services Provided', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'The transport office offers the following services:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Issuance of Bus Passes'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Management of Bus Routes'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Assistance with Transport-related Queries'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Coordination with Transport Service Providers'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Handling of Transport Complaints'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
