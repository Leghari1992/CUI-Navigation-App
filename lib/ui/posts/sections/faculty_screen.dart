import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Faculty Info',
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: FacultyScreen(),
  ));
}

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;
    final bgColor = theme.scaffoldBackgroundColor;
    final headingTextColor = theme.textTheme.titleLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Faculty Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroCard(context, textColor, isDark),  // Pass context to the method
            const SizedBox(height: 24),
            _buildCheckAvailabilityButton(context),
            const SizedBox(height: 30),
            Text(
              'Faculty Departments',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: headingTextColor, // Use theme text color here
              ),
            ),
            const SizedBox(height: 10),
            ..._facultyLinks.map((entry) => _buildFacultyCard(entry['title']!, entry['url']!, textColor, isDark)),
          ],
        ),
      ),
    );
  }

  // Modify this method to accept BuildContext, textColor, and isDark
  Widget _buildIntroCard(BuildContext context, Color textColor, bool isDark) {
    final theme = Theme.of(context);
    final headingTextColor = theme.textTheme.titleLarge?.color ?? Colors.black;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDark ? Colors.grey[900] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome to COMSATS University Islamabad (CUI)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: headingTextColor, // Dynamic color based on theme
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'CUI is a leading institution in Pakistan known for its exceptional academic standards and research in various fields',
              style: TextStyle(fontSize: 16, color: textColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 12),
            Text(
              'Use the resources below to view department-wise faculty profiles or check teacher availability.',
              style: TextStyle(fontSize: 16, color: textColor),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckAvailabilityButton(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.schedule, size: 20),
        label: const Text('Check Teacher Availability'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FacultyAvailabilityScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.blue[300] : Colors.indigo,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildFacultyCard(String title, String url, Color textColor, bool isDark) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: isDark ? Colors.blueGrey[800] : Colors.white,
      child: ListTile(
        leading: Icon(Icons.link, color: isDark ? Colors.white : Colors.indigo), // Dynamic icon color
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: isDark ? Colors.white : Colors.indigo), // Dynamic icon color
        onTap: () => _launchURL(url),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $url';
    }
  }

  final List<Map<String, String>> _facultyLinks = const [
    {'title': 'Electrical Engineering Faculty', 'url': 'https://ww2.comsats.edu.pk/ee/Faculty.aspx'},
    {'title': 'Computer Engineering Faculty', 'url': 'https://ww2.comsats.edu.pk/ce/faculty.aspx'},
    {'title': 'Art and Design Faculty', 'url': 'https://ww2.comsats.edu.pk/artdesign/faculty.aspx'},
    {'title': 'Architecture Faculty', 'url': 'https://ww2.comsats.edu.pk/arch/faculty.aspx'},
    {'title': 'Computer Science Faculty', 'url': 'https://ww2.comsats.edu.pk/cs/faculty.aspx'},
    {'title': 'Health Informatics Faculty', 'url': 'https://ww2.comsats.edu.pk/hi/faculty.aspx'},
    {'title': 'Physics Faculty', 'url': 'https://ww2.comsats.edu.pk/phy/faculty.aspx'},
    {'title': 'Humanities Faculty', 'url': 'https://ww2.comsats.edu.pk/humanities/faculty.aspx'},
    {'title': 'Chemistry Faculty', 'url': 'https://ww2.comsats.edu.pk/chemistry/faculty.aspx'},
    {'title': 'Mathematics Faculty', 'url': 'https://ww2.comsats.edu.pk/math/faculty.aspx'},
    {'title': 'Meteorology Faculty', 'url': 'https://ww2.comsats.edu.pk/Meteorology/faculty.aspx'},
    {'title': 'BioSciences Faculty', 'url': 'https://ww2.comsats.edu.pk/bio/faculty.aspx'},
    {'title': 'Management Sciences Faculty', 'url': 'https://ww2.comsats.edu.pk/ms/faculty.aspx'},
    {'title': 'Economics Faculty', 'url': 'https://ww2.comsats.edu.pk/economics/faculty.aspx'},
  ];
}





class FacultyAvailabilityScreen extends StatelessWidget {
  const FacultyAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final borderColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: _buildDataTable(context, textColor, borderColor),
    );
  }

  Widget _buildDataTable(BuildContext context, Color textColor, Color borderColor) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('StaffAvailability').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs.toList()
          ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

        final headers = [
          'Staff ID',
          'Staff Name',
          'Department',
          'Room',
          'Floor',
          'Availability Status',
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(color: borderColor),
              defaultColumnWidth: const FixedColumnWidth(150),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.indigo),
                  children: headers
                      .map((header) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      header,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white, // Keep headers white always
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ))
                      .toList(),
                ),
                ...docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return TableRow(children: [
                    _tableCell(doc.id, textColor),
                    _tableCell(data['Staff Name'], textColor),
                    _tableCell(data['Department'], textColor),
                    _tableCell(data['Room'], textColor),
                    _tableCell(data['Floor'], textColor),
                    _tableCell(data['Availability Status'], textColor),
                  ]);
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _tableCell(String? text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: textColor),
      ),
    );
  }
}
