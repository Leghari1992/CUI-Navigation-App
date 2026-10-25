import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ECE extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Academic Block-I', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/ab1.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/ece.jpg',
              // Adjust path as per your assets folder structure
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Overview',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Academic Block-I is the Department of Electrical and Computer Engineering. At the Department of Electrical and Computer Engineering at COMSATS University Islamabad, we value diversity and promote global perspectives. Since our inception, we have been dedicated to providing quality engineering education at both the undergraduate and graduate levels.\n',
              style: TextStyle(fontSize: 16.0),
              // textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              'Academic Programs',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Undergraduate',
              '\u2022Bachelor of Science (BS) in Computer Engineering\n\u2022Bachelor of Science (BS) in Electrical (Electronics) Engineering\n\u2022Bachelor of Science (BS) in Electrical Engineering',
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Electrical Engineering\n\u2022Master of Science (MS) in Computer Engineering',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Doctor of Philosophy (PhD)',
              '\u2022Doctor of Philosophy (PhD) in Electrical Engineering\n\u2022Doctor of Philosophy (PhD) in Computer Engineering',
            ),
            SizedBox(height: 30.0),
            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0, color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/ee/'),
              child: Text(
                'https://ww2.comsats.edu.pk/ee/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
               //   decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 20.0),
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
        title: Text('Room Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20.0),
            Text(
              'Ground Floor',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Lecture Halls',
              '\u2022Lecture Hall Room G06 EE\n\u2022Lecture Hall Room G07\n\u2022Lecture Hall Room G08',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022ECE Computer Lab-2 Room G01\n\u2022Power System Lab Room G15\n\u2022Electrical Machine Lab Room G11\n\u2022Communication Lab Room G-12\n\u2022ECE Computer Lab-1 Room G-13',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022Reception Desk\n\u2022Printing and Thesis Binding Shop\n\u2022Media Control Room G03\n\u2022Elect Room 103',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Female Toilet Room G05\n',
            ),
            SizedBox(height: 20.0),
            Text(
              'First Floor',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Lecture Halls',
              '\u2022Lecture Hall Room 108\n\u2022Lecture Hall Room 107\n\u2022Lecture Hall Room 106',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Project Lab Room 111\n\u2022ECE lab -1 Room 112\n\u2022Microwave and mm-wave circuit fabrication laboratory',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022RF research Room 101\n\u2022Elect Room 132\n\u2022Faculty Offices\n\u2022HOD Front Office\n\u2022Conference Room\n\u2022Data Center IT\n\u2022Studio-2 Room 113\n\u2022Tuck Shop',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Male Toilet Room 105\n',
            ),
            SizedBox(height: 20.0),
            Text(
              'Second Floor',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Lecture Halls',
              '\u2022Lecture Hall Room 207\n\u2022Lecture Hall Room 206\n\u2022Lecture Hall Room 205',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Modeling and Simulation Lab Room 201\n\u2022PCD Lab Room 202\n\u2022ECE Lab-3 Room 213\n\u2022ECE Computer Lab-3 Room 211\n\u2022ECE Lab-2 Room 212',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022Elect Room 233\n\u2022Undergraduate Front Office Room 232\n\u2022Faculty Offices\n\u2022Conference Room\n\u2022Elect Room 302',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Male Toilet Room 204\n',
            ),
            SizedBox(height: 20.0),
            Text(
              'Third Floor',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Labs',
              '\u2022ECE lab 4 Room 311\n\u2022ECE Lab 6 Room 314\n\u2022ECE lab 5 Room 312',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022Seminar Hall Room 301\n\u2022Faculty Offices\n\u2022Graduate Front Office\n\u2022Female Common Room',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022Female Toilet\n',
            ),
            SizedBox(height: 20.0),
            Text(
              'Fourth Floor',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'CAST:',
              '\u2022Centre for Advance Studies in Telecommunications',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Simulation Labs',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022Director Office\n\u2022Faculty Offices\n\u2022Conference Room',
            ),
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


