import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcademicBlockIIIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Academic Block-III', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/ab3.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/bio.jpg',
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
              'The Academic Block-III consists of many Departments.\n\u2022Department of Bio Science\n\u2022Department of Management Sciences\n\u2022Department of Economics\n\u2022Department of Humanities\n\u2022Department of Mathematics\n\u2022Department of Meteorology  ',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),


            Text(
              'Department of Bio Sciences',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Biosciences at COMSATS University Islamabad (CUI), was established a few years ago. It launched the BS Bioinformatics program in 2003, which now enrolls over 125 students. This program is gaining popularity nationwide and aims to meet Pakistan\'s future needs in this vital field.\nA key challenge is to understand our place and role in the world and generate fundamental knowledge to enhance our national policies, economies, and social structure. Biosciences provide insights into global changes within the scientific context of living systems and contribute to improving human well-being.',
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
              '\u2022Bachelor of Science (BS) in Biosciences\n\u2022Bachelor of Science (BS) in Bioinformatics',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Biochemistry and Molecular Biology\n\u2022Master of Science (MS) in Biosciences\n\u2022Master of Science (MS) in Microbiology and Immunology\n\u2022Master of Science (MS) in Molecular Genetics\n\u2022Master of Science (MS) in Molecular Virology\n\u2022Master of Science (MS) in Bioinformatics',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Doctor of Philosophy (PhD)',
              '\u2022Doctor of Philosophy (PhD) in Biochemistry and Molecular Biology\n\u2022Doctor of Philosophy (PhD) in Biosciences\n\u2022Doctor of Philosophy (PhD) in Microbiology and Immunology\n\u2022Doctor of Philosophy (PhD) in Molecular Genetics\n\u2022Doctor of Philosophy (PhD) in Bioinformatics'
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/bio/'),
              child: Text(
                'https://ww2.comsats.edu.pk/bio/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text(
              'Department of Management Sciences',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Management Sciences (DMS) aims to fulfill CUI\'s broader social mission by offering high-quality academic programs that incorporate advanced technologies and contemporary managerial practices.\nAt the Islamabad campus, the Department of Management Sciences has become the most dynamic and vibrant department within CUI. It has adopted an innovative approach to business education, emphasizing outcome-based learning and fostering strong connections between academia and industry.',
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
              '\u2022Bachelor of Science (BS) in Business Administration\n\u2022Bachelor of Science (BS) in Accounting and Finance\n\u2022Bachelor of Science (BS) in Business Data Analytics\n\u2022Bachelor of Science (BS) in Audit and Taxation',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Management Science\n\u2022Master of Science (MS) in Project Management\n\u2022Master of Business Administration (MBA)',
            ),

            SizedBox(height: 20.0),
            _buildSection(
                'Doctor of Philosophy (PhD)',
                '\u2022Doctor of Philosophy (PhD) in Management Sciences'
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/ms/#'),
              child: Text(
                'https://ww2.comsats.edu.pk/ms/#',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text(
              'Department of Economics',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Economics is dedicated to advancing knowledge in all core areas of the field. It stands as one of the leading departments in Pakistan, distinguished by its strong PhD faculty and the variety of courses and research publications it offers. The department boasts 14 faculty members, including 10 PhDs who have earned their doctorates from prestigious national and international universities.',
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
              '\u2022Bachelor of Science (BS) in Economics with Data Science\n\u2022Bachelor of Science (BS) in Economics',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Economics\n\u2022Doctor of Philosophy (PhD) in Economics',
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/economics/'),
              child: Text(
                'https://ww2.comsats.edu.pk/economics/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text(
              'Department of Humanities',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Humanities at CUI, Islamabad Campus, is a relatively new but vibrant addition, featuring 57 faculty members (25 with PhDs and 32 with MS/MPhil degrees). This department is a thriving community of educators, researchers, and practitioners, offering approximately 90 courses in Humanities subjects. These include Functional English, Technical Writing, Business Communication, French, Psychology, Sociology, Pakistan Studies, International Relations, and Pakistan Studies.',
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
              '\u2022Bachelor of Science in International Relations\n\u2022Bachelor of Science in Media and Communication Studies\n\u2022Bachelor of Science in English\n\u2022Bachelor of Science in Psychology',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in English (Literature)\n\u2022Master of Science (MS) in English (Linguistics)\n\u2022Master of Science (MS) in International Relations\n\u2022Master of Science (MS) in English (Linguistics and Literature)\n\u2022Master of Science (MS) in (SEERAH Studies)\n\u2022Doctor of Philosophy (PhD) in International Relations',
            ),

            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/humanities/'),
              child: Text(
                'https://ww2.comsats.edu.pk/humanities/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            Text(
              'Department of Mathematics',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Mathematics is a source of pride for CU Islamabad, renowned for its highly qualified and distinguished faculty. It serves as a hub for excellent research and analysis.\nEstablished in 2001, the department launched a four-year BS Mathematics program in Fall 2002 at the Islamabad Campus. An MS program leading to a PhD in Mathematics followed in Fall 2004.',
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
              '\u2022Bachelor of Science (BS) in Mathematics with Data Science\n\u2022Bachelor of Science (BS) in Mathematics',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022Master of Science (MS) in Mathematics',
            ),

            SizedBox(height: 20.0),
            _buildSection(
                'Doctor of Philosophy (PhD)',
                '\u2022Doctor of Philosophy (PhD) in Mathematics'
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/math/'),
              child: Text(
                'https://ww2.comsats.edu.pk/math/',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ),

            SizedBox(height: 40.0),

            Text(
              'Department of Meteorology',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The Department of Meteorology encompasses a variety of multidisciplinary fields, providing services to specialists from diverse backgrounds, including Meteorology, Remote Sensing, Earth and Environmental Sciences, Geography, Geodesy, and Geographic Information Systems. Established in 2005, the department is actively involved in research and teaching. In addition to its research and educational activities, the department regularly hosts seminars, workshops, and organizes national and international conferences.',
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
              '\u2022Bachelor of Science (BS) in Remote Sensing and GIS',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Graduate',
              '\u2022MS in Meteorology\u2022MS in Remote Sensing (RS) and GIS',
            ),

            SizedBox(height: 20.0),
            _buildSection(
                'Doctor of Philosophy (PhD)',
                '\u2022PhD in Meteorology\u2022PhD in Remote Sensing & GIS'
            ),
            SizedBox(height: 30.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0,color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () => _launchURL('https://ww2.comsats.edu.pk/Meteorology/'),
              child: Text(
                'https://ww2.comsats.edu.pk/Meteorology/',
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
        centerTitle : true,
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
                'Basement',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Classrooms',
                '\u2022Room B02 Classroom\n'
                    '\u2022Room B03 Classroom\n'
                    '\u2022Room B04 Classroom\n'
                    '\u2022Room B07 Classroom\n'
                    '\u2022Room B08 Classroom\n'
                    '\u2022Room B10 Classroom\n'
                    '\u2022Room B11 Classroom\n'
                    '\u2022Room B27 Classroom\n'
                    '\u2022Room B28 Classroom\n'
                    '\u2022Room B30 Classroom\n'
                    '\u2022Room B33 Classroom\n'
                    '\u2022Room B34 Classroom\n'
                    '\u2022Room B35 Classroom\n'
                    '\u2022Room B36 Classroom\n'
                    '\u2022Room B37 Classroom',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Others',
                '\u2022Room B05a Electric Room\n'
                    '\u2022Room B05b Male Washroom\n'
                    '\u2022Room B06 Electric Room\n'
                    '\u2022Room B07 Office\n'
                    '\u2022Room B26 Office\n'
                    '\u2022Room B28 Sitting Area\n'
                    '\u2022Stationary Room\n'
                    '\u2022Undergraduate Office\n'
                    '\u2022Tuck Shop',
              ),
              SizedBox(height: 20.0),
              Text(
                'Ground Floor',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Labs',
                '\u2022Room G02 Lab\n'
                    '\u2022Room G03 Bioinformatics Lab\n'
                    '\u2022Room G03 Molecular Virology Lab\n'
                    '\u2022Room G07a Lab\n'
                    '\u2022Room G07b Microbiology Lab\n'
                    '\u2022Room G08 Lab\n'
                    '\u2022Room G09/G10 Lab\n'
                    '\u2022Room G10 Computer Lab\n'
                    '\u2022Room G11 Biotechnology Lab\n'
                    '\u2022Room G12 Environmental Toxicology Lab\n'
                    '\u2022Room G28 Lab\n'
                    '\u2022Room G40 Lab\n'
                    '\u2022Room G43 Lab',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Others',
                '\u2022Room G01 Network Room\n'
                    '\u2022Room G05a Electric Room\n'
                    '\u2022Room G06 Electric Room\n'
                    '\u2022Room G26 Coordinator Room\n'
                    '\u2022Room G32 Faculty Room\n'
                    '\u2022Room G36a Electric Room\n'
                    '\u2022Room G37 Growth Chamber Room\n'
                    '\u2022Room G38 Faculty Room\n'
                    '\u2022Room G40 Teachers’ Offices\n'
                    '\u2022Room G41 Faculty Room',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Toilet',
                '\u2022Room G04 Female Washroom\n'
                    '\u2022Room G05 Male Washroom\n'
                    '\u2022Room G31a Faculty Male Washroom\n'
                    '\u2022Room G35 Faculty Female Washroom',
              ),
              SizedBox(height: 20.0),
              Text(
                'First Floor',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Labs',
                '\u2022Room 105c Lab\n'
                    '\u2022Room 105d Analytical Lab\n'
                    '\u2022Room 109 Translational Genomics Lab\n'
                    '\u2022Room 110 Functional Genomics Lab\n'
                    '\u2022Room 121/111 Lab\n'
                    '\u2022Room 129 CG Lab\n'
                    '\u2022Room 143 Microbiology Lab',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Others',
                '\u2022Room 102 In Charge Security and Safety Office\n'
                    '\u2022Room 103 Professor Office (Dr. Tayyaba Yasmeen)\n'
                    '\u2022Room 104 Biosciences Office Exam Support Team\n'
                    '\u2022Room 105a Centrifuge Room\n'
                    '\u2022Room 105b Mammalian Tissue Room\n'
                    '\u2022Room 105e Microscopy Room\n'
                    '\u2022Room 126 HOD Office\n'
                    '\u2022Room 127 Chairman Coordination Office\n'
                    '\u2022Room 128 Faculty Room\n'
                    '\u2022Room 130 Faculty Room\n'
                    '\u2022Room 131 Faculty Room\n'
                    '\u2022Room 133 Faculty Room\n'
                    '\u2022Room 137 Environmental Sample Processing Room',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Toilet',
                '\u2022Room 106 Faculty Female Washroom\n'
                    '\u2022Room 107 Faculty Male Washroom\n'
                    '\u2022Room 132 Cancer Genomics Lab\n'
                    '\u2022Room 135 Female Washroom\n'
                    '\u2022Room 136 Male Faculty Washroom',
              ),
              SizedBox(height: 20.0),
              Text(
                'Second Floor',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Classrooms',
                '\u2022Room 204a Classroom\n'
                    '\u2022Room 204b Classroom\n'
                    '\u2022Room 208a Classroom\n'
                    '\u2022Room 208b Classroom\n'
                    '\u2022Room 209 Classroom\n'
                    '\u2022Room 210 Classroom\n'
                    '\u2022Room 211 Classroom\n'
                    '\u2022Room 234a Classroom\n'
                    '\u2022Room 234b Classroom',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Lecture Halls',
                '\u2022Room 212 Lecture Hall\n'
                    '\u2022Room 229 Lecture Hall\n'
                    '\u2022Room 230 Lecture Hall\n'
                    '\u2022Room 235 Lecture Hall',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Others',
                '\u2022Room 201 Coordination Office\n'
                    '\u2022Room 202 Teacher Office\n'
                    '\u2022Room 203 Doctor Aruba Sharif (In Charge BS(AF))\n'
                    '\u2022Room 206a Electric Room\n'
                    '\u2022Room 206b Electric Room\n'
                    '\u2022Room 207 Electric Room\n'
                    '\u2022Room 226 Head of Department Office\n'
                    '\u2022Room 227 Staff Office to HOD\n'
                    '\u2022Room 228 Teachers’ Office\n'
                    '\u2022Room 232a Faculty Office\n'
                    '\u2022Room 232b Kitchen\n'
                    '\u2022Room 233 Graduate Office Management Sciences\n'
                    '\u2022DARC Office Management Sciences\n'
                    '\u2022Coordination Office BBA BAF',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Toilet',
                '\u2022Room 205 Female Washroom\n'
                    '\u2022Room 206 Male Washroom\n'
                    '\u2022Room 231 Female Washroom',
              ),

              // Third Floor
              SizedBox(height: 20.0),
              Text(
                'Third Floor',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Classrooms',
                '\u2022Room 311 Classroom',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Lecture Halls',
                '\u2022Room 303/304 Lecture Room\n'
                    '\u2022Room 309a/b Lecture Hall\n'
                    '\u2022Room 310 Lecture Hall',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Lab',
                '\u2022Room 306 Experimental Lab',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Others',
                '\u2022Room 301 Humanities Department Front Office\n'
                    '\u2022Room 305 Electric Room\n'
                    '\u2022Room 307 Female Staff Room\n'
                    '\u2022Room 309 Language Lab\n'
                    '\u2022Room 312 Biosciences Faculty\n'
                    '\u2022Room 313 Biosciences Faculty\n'
                    '\u2022Room 314 Biosciences Faculty\n'
                    '\u2022Room 315 Biosciences Faculty\n'
                    '\u2022Room 316 Biosciences Faculty\n'
                    '\u2022Room 317 Biosciences Faculty\n'
                    '\u2022Room 318 Biosciences Faculty\n'
                    '\u2022Room 319 Biosciences Faculty\n'
                    '\u2022Room 320 Biosciences Faculty Room\n'
                    '\u2022Room 321 Biosciences Faculty Room\n'
                    '\u2022Room 322 Biosciences Faculty Room\n'
                    '\u2022Room 323 Biosciences Faculty Room\n'
                    '\u2022Room 324 Humanities Faculty Room\n'
                    '\u2022Room 325 Humanities Faculty Room\n'
                    '\u2022Room 326 Humanities Faculty Room\n'
                    '\u2022Room 327 Humanities Faculty Room\n'
                    '\u2022Room 328 Office\n'
                    '\u2022Room 329 Kitchen\n'
                    '\u2022Room 331 Electric Room\n'
                    '\u2022Room 333a/b/c Computational Biology and Bioinformatics Group\n'
                    '\u2022Room 334 Faculty Offices\n'
                    '\u2022Sitting Area',
              ),
              SizedBox(height: 20.0),
              _buildSection(
                'Toilet',
                '\u2022Room 308 Female Washroom\n'
                    '\u2022Room 330 Faculty Male Washroom\n'
                    '\u2022Room 332 Female Washroom',
              ),

// Fourth Floor
              SizedBox(height: 20.0),
              Text(
                'Fourth Floor',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              ),
              SizedBox(height: 10.0),
              _buildSection(
                'Others',
                '\u2022Room 401 Faculty Office\n'
                    '\u2022Room 402 Faculty Office\n'
                    '\u2022Room 403 Uswa Office\n'
                    '\u2022Room 404 Faculty Office\n'
                    '\u2022Room 405 Faculty Office\n'
                    '\u2022Room 406 Faculty Office\n'
                    '\u2022Room 407 Faculty Office\n'
                    '\u2022Room 408 Faculty Office\n'
                    '\u2022Room 409 Faculty Office\n'
                    '\u2022Room 410 Faculty Office\n'
                    '\u2022Room 411 Faculty Office\n'
                    '\u2022Room 412 Faculty Office\n'
                    '\u2022Room 413 Faculty Office\n'
                    '\u2022Praying Area\n'
                    '\u2022Store\n'
                    '\u2022Rooftop',
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