import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademicBlockIIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Academic Block-II', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/ab2.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/csdep.jpg',
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
              'The Academic Block-II consists of many Departments.\n\u2022Department of Computer Science\n\u2022Department of Architecture\n\u2022Department of Art & Design\n\u2022Department of Health Informatics ',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Department of Computer Science',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Computer Science at COMSATS University Islamabad (CUI) boasts world-class faculty, a successful alumni network, and flexible degree programs designed to meet the demands of a vast job market. We are dedicated to fostering innovation and excellence in education, providing our students with the skills and knowledge necessary to excel in their careers. With a strong emphasis on research and practical experience, we prepare our graduates to become leaders in the field of computer science.',
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
              '\u2022Bachelor of Science in Computer Science\n\u2022Bachelor of Science in Software Engineering\n\u2022Bachelor of Science in Artificial Intelligence\n\u2022Bachelor of Science in Cyber Security\nBachelor of Science in Data Science',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022MS in Computer Science\n\u2022MS in Software Engineering\n\u2022MS in Artificial Intelligence',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Doctor of Philosophy (PhD)',
              '\u2022PhD in Computer Science',
            ),
            SizedBox(height: 30.0),
            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color: Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/cs/'),
              child: Text(
                'https://ww2.comsats.edu.pk/cs/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),

            SizedBox(height: 40.0),

            Text(
              'Department of Architecture',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The decision to establish a Department of Architecture at Islamabad presents a unique opportunity to redefine architectural education in Pakistan. It allows for a re-evaluation and enhancement of the current educational standards, aiming to reintroduce the integration of Art into Architecture, which has diminished over the centuries. The goal is to foster holistic thinking about the conceptual foundations of design.The department',
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
              '\u2022Bachelor of Architecture: B. Arch',
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/arch/'),
              child: Text(
                'https://ww2.comsats.edu.pk/arch/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text(
              'Department of Art & Design',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Art & Design (DoAD), though relatively young, is a vibrant space that fosters creativity, experimentation, and critical engagement with the local communitys social and cultural fabric. It encourages students to explore and develop their methods through research and hands-on creation. With an emphasis on an interdisciplinary approach to teaching, the Department of Art & Design offers programs that provide opportunities for learning across various fields of Visual Arts, catering to young aspiring artists.',
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
              '\u2022Bachelor of Fine Arts\n\u2022Bachelor of Design\n\u2022Bachelor of Interior Design',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science in Art Education',
            ),

            SizedBox(height: 30.0),
            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/artdesign/'),
              child: Text(
                'https://ww2.comsats.edu.pk/artdesign/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),


            Text(
              'Department of Health Informatics',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'In todays, data-driven world, the intersection of healthcare and technology has become increasingly essential. Health Informatics program at COMSATS University, Islamabad. is at the forefront of this convergence, offering a multidisciplinary approach to harnessing the power of data to improve healthcare outcomes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Academic Programs',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Health Informatics',
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/hi/'),
              child: Text(
                'https://ww2.comsats.edu.pk/hi/',
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
        SizedBox(height: 10.0),
            Text(
              'Department of Computer Science',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
        _buildSection(
          'Lecture Halls',
          '\u2022Lecture Hall Room G05\n\u2022Lecture Hall Room G06\n\u2022Lecture Hall Room G07\n\u2022Lecture Hall G08',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Labs',
          '\u2022Computer Lab 4\n\u2022Computer Lab 5 Room G25\n\u2022Computer Lab 6 Room G22\n\u2022Project Lab 1 Room G02\n\u2022Graduate Lab Room G01',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Others:',
          '\u2022Reception Desk\n\u2022Ground Floor Printer Shop\n\u2022Cisco Academy\n\u2022Tuck-shop\n\u2022Waiting Area',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Toilet',
          '\u2022Two Female washroom\n\u2022Male washroom',
        ),
        SizedBox(height: 20.0),
        Text(
          'First Floor',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
        ),
        SizedBox(height: 10.0),
            Text(
              'Department of Computer Science',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
        _buildSection(
          'Lecture Halls',
          '\u2022Lecture Hall 105\n\u2022Lecture Hall 106\n\u2022Lecture Hall 107\n\u2022Lecture Hall 108\n\u2022Lecture Hall 109\n\u2022Lecture Hall 110\n\u2022Lecture Hall 111\nLecture Hall 112',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Labs',
          '\u2022Computer Lab 7\n\u2022Computer Lab 8\n\u2022Computer Lab 9',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Others:',
          '\u2022First Floor Printer Shop\n\u2022Haier International Smart Education Experience Center\n\u2022Sitting Area',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Toilet',
          '\u2022Two Male washrooms\n\u2022Female Washroom',
        ),
        SizedBox(height: 20.0),

        Text(
          'Second Floor',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
        ),
        SizedBox(height: 10.0),
            Text(
              'Department of Computer Science\nDepartment of Health Informatics',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
        _buildSection(
          'Lecture Halls',
          '\u2022Lecture Hall 206\n\u2022Lecture Hall 207\n\u2022Lecture Hall 208\n\u2022Lecture Hall 209\n\u2022Lecture Hall 210\n\u2022Lecture Hall 211\n\u2022Lecture Hall 212\n\u2022Lecture Hall 213',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Labs',
          '\u2022Computer Lab 10 Room 221\n\u2022Computer Lab 11 Room 210\n\u2022Computer Lab 12 Room 211\n\u2022Computer Lab 13 Room 203',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Others:',
          '\u2022Sitting Area',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Toilet',
          '\u2022Two Male washroom\n\u2022Female Washroom',
        ),
        SizedBox(height: 20.0),

        Text(
          'Third Floor',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
        ),
        SizedBox(height: 10.0),
            Text(
              'Department of Computer Science\nDepartment of Architecture\nDepartment of Art & Design',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),

        SizedBox(height: 10.0),
        _buildSection(
          'Lecture Halls',
          '\u2022Lecture Hall 305\n\u2022Lecture Hall 306\n\u2022Lecture Hall 307\n\u2022Lecture Hall 308',
        ),

        _buildSection(
          'Labs',
          '\u2022Computer Lab 15\n\u2022Computer Lab 16\n\u2022Project Lab 2\n\u2022Project Lab 3',
        ),
        SizedBox(height: 20.0),
        _buildSection(
          'Toilet',
          '\u2022Male washroom\n\u2022Female washroom',
        ),
        SizedBox(height:20.0),
            _buildSection(
              'Others',
              '\u2022322-Thesis Studio',
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


