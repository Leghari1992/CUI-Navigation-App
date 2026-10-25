import 'package:again1/ui/posts/sections/sub_sections/buildings/academic_block_i.dart';
import 'package:again1/ui/posts/sections/sub_sections/buildings/academic_block_iii.dart';
import 'package:again1/ui/posts/sections/sub_sections/buildings/physics_block.dart';
import 'package:again1/ui/posts/sections/sub_sections/buildings/rd_lab.dart';
import 'package:flutter/material.dart';
import 'academic_block_ii.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildingInformationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> buildings = [
    {'name': 'Academic Block I', 'icon': Icons.school, 'screen': ECE()},
    {'name': 'Physics Block', 'icon': Icons.science, 'screen': PhysicsBlockScreen()},
    {'name': 'Academic Block II', 'icon': Icons.school, 'screen': AcademicBlockIIScreen()},
    {'name': 'N-Block', 'icon': Icons.apartment, 'screen': NBlockScreen()},
    {'name': 'Academic Block III', 'icon': Icons.school, 'screen': AcademicBlockIIIScreen()},
    {'name': 'R&D Lab', 'icon': Icons.science, 'screen': RDLabScreen()},
    {'name': 'Faculty Block I', 'icon': Icons.person, 'screen': FacultyBlockIScreen()},
    {'name': 'SSBC', 'icon': Icons.business, 'screen': SSBCScreen()},
    {'name': 'Faculty Block II', 'icon': Icons.person, 'screen': FacultyBlockIIScreen()},
    {'name': 'Library', 'icon': Icons.library_books, 'screen': LibraryScreen()},


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Building Info',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Add space below the app bar
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => building['screen']),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(building['icon'], size: 40, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        building['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

class FacultyBlockIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Faculty Block-I', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/f1.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/f1.jpg',
              // Adjust path as per your assets folder structure
              height: 350,
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
              'Faculty Block 1 is a dynamic center for academic and administrative functions, fostering creativity and collaboration across various disciplines. It brings together state-of-the-art studios, specialized faculty offices, and essential administrative services, providing a comprehensive environment for both education and innovation.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),


            Text(
              'Floor Infos',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Ground Floor',
              '\u2022Art and Design Studios\n\u2022MIS Section -IT Center\n\u2022Meeting Rooms\n\u2022Public Relations Office',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'First Floor',
              '\u2022Faculty of Department of Mathematics',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Second Floor',
              '\u2022Faculty of Department of Physics\n\u2022Faculty of Department of Chemistry',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Third Floor',
              '\u2022Faculty of Department of Physics\n\u2022Faculty of Department of Humanities',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Fourth Floor',
              '\u2022Rector Secretariat\n\u2022Incharge Campus\n\u2022Register Office\n\u2022Deans of Faculties\n\u2022Director PD & HRD\n\u2022Head International Office\n\u2022Incharge ORIC\n\u2022Controller of Examination\n\u2022Head DITS',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Fifth Floor',
              '\u2022Virtual Campus\n\u2022Services Section',
            ),

            SizedBox(height: 50.0),

            Text(
              'For Faculty details please navigate to Faculty on Home Page:',
              style: TextStyle(fontSize: 16.0, color:Colors.red),
              textAlign: TextAlign.justify,
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




class NBlockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('N Block', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/N.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/N.jpg',
              // Adjust path as per your assets folder structure
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Overview',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'The N Block of COMSATS University Islamabad houses the Department of Management Sciences,which is known for its innovative approach to business education, bridging academia and industry. This department has gained a reputation for being dynamic and vibrant across all COMSATS campuses. The N Block also supports various academic and administrative functions, contributing to the university\'s role in providing high-quality education characterized by modern managerial practices and cutting-edge technologies.It only has one ground floor at the moment',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Ground Floor',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Rooms',
              '\u2022N01\n\u2022N02\n\u2022N03\n\u2022N04\n\u2022N05\n\u2022N06\n\u2022N07\n\u2022N08\n\u2022N09A\n\u2022N09B\n\u2022N10\n\u2022N11\n\u2022N12',
            ),
            SizedBox(height: 10.0),
            _buildSection(
              'Others',
              '\u2022Coordination Office',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Toilets',
              '\u2022Female Toilet\n\u2022Male Toilet',
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


class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Library', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/lib.PNG',
              // Adjust path as per your assets folder structure
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/library.jpg',
              // Adjust path as per your assets folder structure
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Overview',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(height: 10.0),
            Text(
              'Welcome to the Junaid Zaidi Library, the core of research and a hub for lifelong learning and discovery. Providing unrestricted access to intellectual records, the library strives to offer high-quality services to the educational community of COMSATS University Islamabad.\nEquipped with advanced technologies such as the Integrated Library System (ILS), RFID, and a Self-Check System for issuing and returning materials, the Junaid Zaidi Library is among the most modern libraries in Pakistan. It is, in fact, the first library in the country to implement a comprehensive RFID solution.\n',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Library Resources',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),

            Text(
              '\u202265000 Printed Books\n\u2022100000 e-books\n\u202220000 Peer Reviewed Electronic Journals\n\u20224000 Theses\n\u202224 Electronic Databases\n',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              '300 computer systems with necessary softwares installed and internet connectivity is another spectacular feature of the library. Wireless internet connectivity on all (four) floors of the library make use of the internet convenient (through personal gadgets) for library users and visitors.\n',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Exclusive Facilities',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),

            Text(
              '\u2022Collaborative Learning Spaces\n\u2022Group Study Rooms\n\u2022Wireless Internet Connectivity\n\u2022Study Carrels\n\u2022Research Cubicles with Computer\n\u2022Seating Capacity for 1000 Users\n\u2022300 Computer Workstations\n\u2022Video Conferencing Room\n\u2022Conference Room\n\u2022Information Commons\n\u2022Easy Seating\n\u2022Special Learning Zones\n\u2022Art Gallery\n\u2022Faculty Commons\n\u2022Drop Box\n\u2022Self Check System',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Special Services',
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),

            Text(
              '\u2022Research Support Services\n\u2022Plagiarism Detection Services\n\u2022Citation and Referencing Services\n\u2022Current Awareness Services\n\u2022Selective Dissemination of Information\n\u2022Personalized Library Services\n\u2022Electronic Document Delivery\n\u2022Inter Library Loan\n\u2022Real Time Help Services through Chat\n\u2022User Education Services\n\u2022VPN Access (off campus access)\n\u2022Online Public Access Catalogue (OPAC)\n\u2022Mobile App\n\u2022Online Reservation of Library Material\n\u2022Photocopying and Printing\n\u2022Newspapers Clippings Services',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 40.0),

            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0, color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _launchURL('https://library.comsats.edu.pk'),
              child: Text(
                'https://library.comsats.edu.pk',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
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
}


class SSBCScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('SSBC', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/S.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/SSbc.jpg',
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
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Student Start-up Business Center (SSBC)\nEntrepreneurship and innovation are crucial drivers of global economic and social development.\n\nUniversity based entrepreneurship ecosystems creates a supportive environment where entrepreneurship and innovation can flourish.\n\nThe Student Startup Business Centre (SSBC) at CUI was established with support from the Higher Education Commission of Pakistan and the Promotion of Education in Pakistan Foundation, Inc. (USA).\n\nThe program aims to promote talented students\' entrepreneurship and enhance their practical learning experience at the Institute. The primary objective of the Centre is to support student startup businesses by providing necessary mentoring and initial financial resources through its Startup Entrepreneurship Fund. The SSBC will facilitate a continuous stream of student-led businesses and innovations at CUI.',
              style: TextStyle(fontSize: 16.0),
              //   textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              'SSBC Offers',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\u2022 Business Plan Development\n\u2022 Trainings and Workshops\n\u2022 Mentorship\n\u2022 Free Utilities\n\u2022 Office Space\n\u2022 Seed Funding',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0),
            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _launchURL('https://ssbc.comsats.edu.pk'),
              child: Text(
                'https://ssbc.comsats.edu.pk',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
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
}

class FacultyBlockIIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Faculty Block-II', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo, // Adjust color as per your app's theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/f2.PNG',
              // Adjust path as per your assets folder structure
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/images/f2.jpg',
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
              'Faculty Block II at COMSATS University Islamabad serves as the Admissions Block, playing a pivotal role in the university\'s academic and administrative framework. This building houses the Admissions Office, where prospective students can receive guidance and support throughout the enrollment process. ',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),

            Text(
              'Floor Infos',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Basement',
              '\u2022Faculty of Department of Management Science\n\u2022Department of Economics',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'Ground Floor',
              '\u2022Admission Office\n\u2022student Affairs Department\n\u2022Banks\n\u2022Career Development Center\n\u2022China Study Center\n\u2022Day Care Center',
            ),

            SizedBox(height: 10.0),
            _buildSection(
              'First Floor',
              '\u2022Accounts Department\n\u2022Internal Audit Department\n\u2022Academics Department\n\u2022Examination Department\n\u2022HR-Islamabad Campus',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Second Floor',
              '\u2022Information Technology Center\n\u2022Controller of Examinations\n\u2022COMSIAN Consulting\n\u2022CUonline\n\u2022Procurement Office',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Third Floor',
              '\u2022Treasure Office\u2022Scholarship Management Unit\n\u2022Directorate of P&D and HRD',
            ),
            SizedBox(height: 20.0),
            _buildSection(
              'Fourth Floor',
              '\u2022Human Resource-PS\n\u2022Register Office\n\u2022International Office\n\u2022Faculty Development Academy',
            ),

            SizedBox(height: 20.0),
            _buildSection(
              'Fifth Floor',
              '\u2022Faculty of Department of Meterology\n\u2022Operation and Maintenance Deparment\n\u2022Quality Enhancement Cell',
            ),

            SizedBox(height: 50.0),


            Text(
              'For more details, please visit this website:',
              style: TextStyle(fontSize: 16.0, color:Colors.teal),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _launchURL('https://islamabad.comsats.edu.pk/comsats-admissions.aspx'),
              child: Text(
                'https://islamabad.comsats.edu.pk/comsats-admissions.aspx',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
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
