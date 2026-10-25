import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhysicsBlockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Physics Block', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/PB.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/physics.jpg',
              // Adjust path as per your assets folder structure
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Overview',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Physics at COMSATS University Islamabad was founded in Fall 2003 with the goal of training top-tier scientists using the latest technological advancements. Dedicated to excellence in both teaching and research, the department promotes a culture of continuous learning and scientific inquiry. It is committed to advancing academic excellence, encouraging research innovation, and embracing global perspectives.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),


            Text(
              'Academic Programs',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Undergraduate',
              '\u2022Bachelor of Science (BS) in Physics\n\u2022Bachelor of Science (BS) in Electronics and Computing',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Graduate Admissions\n\u2022Master of Science (MS) in Physics',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Doctor of Philosophy (PhD)',
              '\u2022Doctor of Philosophy (PhD) in Physics',
            ),
            SizedBox(height: 40.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/phy/'),
              child: Text(
                'https://ww2.comsats.edu.pk/phy/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,

                ),
              ),
            ),
            SizedBox(height: 50.0),
            Text(
              'For building\'s room info, please tap on the button below:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomInfoScreen()),
                  );
                },
                icon: Icon(Icons.meeting_room),
                label: Text("Rooms Info", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Adjust button size here
                  textStyle: TextStyle(fontSize: 18), // Adjust text size here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),



          ],
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

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text(
          content,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class RoomInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Room Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),



            Text(
              'Ground Floor',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Modern Physisc Lab 101\n\u2022Optic Lab 102\n\u2022Laser Matter Interaction Lab Rom 103\n\u2022Electrochemical Material Synthesis and devices (EMSD) Room 104\u2022Plasma Lab Room-105\n\u2022Microwave Lab Room-106\n',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Female washroom\n\u2022Male washroom',
            ),
            SizedBox(height: 20.0),
            Text(
              'First Floor',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Thin Film and Material Research Lab Room 201\n\u2022SGM Laboratory Room 202 \n\u2022Catalysis and Sensing Material Lab Room 203\n\u2022Magnetic Material Research Lab Room 204\n\u2022Applied Thermal Physics Lab Room 205\n\u2022Material Science Lab Room 206',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Male washrooms\n\u2022Female Washroom',
            ),
            SizedBox(height: 20.0),

            Text(
              'Second Floor',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Quantum Optics Lab Room 301\n\u2022Project Lab Room 302\n\u2022Computational Research Lab Room 303\n\u2022Radiation Physics Lab Room 304\n\u2022Material Lab Room 305\n\u2022Undergraduate Coordination Office Room 306\n\u2022Radiation Sources and Neutron Architecture Room 307\n\u2022Kitchen Room 308',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Male washroom\n\u2022Female Washroom',
            ),
            SizedBox(height: 20.0),

            Text(
              'Third Floor',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Labs',
              '\u2022Embedded lab Room 401\n\u2022FYP Lab Room 402\n\u2022Micrprocessors (electronics) Lab Room 403\n\u2022Microprocessors Lab Room 404\n\u2022Embedded Systems Lab Room 405',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Male washroom\n\u2022Female washroom',
            ),
            SizedBox(height: 20.0),

          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text(
          content,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}






