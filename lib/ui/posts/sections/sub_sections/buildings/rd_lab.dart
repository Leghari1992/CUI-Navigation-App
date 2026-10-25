import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RDLabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chemistry Dep + R&D Lab', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/R.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/chemistry.jpg',
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

            Text(
              '\n\u2022Department of Chemistry\n\u2022R&D Lab',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Department of Chemistry',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Chemistry at CUI\'s Islamabad campus was established in July 2018 with a vision to excel in teaching, research, and public outreach. By adopting a multidisciplinary curriculum and embracing diversity among our faculty, staff, and students, we aim to become a renowned chemical institute. Our graduates will be trained as critical thinkers and independent learners capable of addressing scientific problems of global significance.',
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
              '\u2022Bachelor of Science (BS) in Chemistry',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Chemistry',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Doctor of Philosophy (PhD)',
              '\u2022Doctor of Philosophy (PhD) in Chemistry',
            ),
            SizedBox(height: 20.0),


            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/chemistry/'),
              child: Text(
                'https://ww2.comsats.edu.pk/chemistry/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                  // decoration: TextDecoration.underline,
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
            SizedBox(height: 10.0),
            _buildSection(
              'Lecture Rooms',
              '\u2022Lecture Room CH-01\n\u2022Lecture Room CH-02\n\u2022Lecture Room CH-03',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Labs',
              '\u2022Lab1 Synthesis Lab\n\u2022Lab 2\n\u2022Lab 3\n\u2022Lab 4 Electro-Chemistry lab\n\u2022Lab 5\n\u2022R & D Lab',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Others:',
              '\u2022Assistant Professor Dr Farukh Room\n\u2022Store',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Toilet',
              '\u2022One Female washroom',
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






