import 'package:flutter/material.dart';
import 'package:again1/ui/posts/sections/sub_sections/medicalcenter/medical_contact.dart';
import 'package:again1/ui/posts/sections/sub_sections/medicalcenter/medical_info.dart';
import 'package:again1/ui/posts/sections/sub_sections/medicalcenter/first_aid_guide.dart';
import 'package:again1/ui/posts/sections/sub_sections/medicalcenter/emergency_numbers.dart';

class EmergencyAssistanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Medical Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15.0),
            // Add the image at the start
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Image.asset(
                'assets/images/M.PNG',
                height: 200, // Adjust height as needed
              ),
            ),

            SizedBox(height: 10),

            // Description or additional information
            Text(
              'Welcome to the Medical Center. Here you can find important medical information and emergency services.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalInfoScreen()),
                );
              },
              icon: Icon(Icons.info, size: 30),
              label: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Medical Information',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalNumbers()),
                );
              },
              icon: Icon(Icons.phone, size: 30),
              label: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Medical Center Contact Info',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                // Navigate to First Aid Guide screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstAidGuide()),
                );
              },
              icon: Icon(Icons.healing, size: 30),
              label: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'First Aid Information',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyNumbers()),
                );
              },
              icon: Icon(Icons.phone, size: 30),
              label: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Other Emergency Services',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
