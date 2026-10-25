import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:again1/ui/posts/sections/sub_sections/gps/navigation_screen.dart';
import 'package:again1/ui/posts/sections/sub_sections/Transport/transport.dart';
import 'package:again1/ui/posts/sections/sub_sections/buildings/building_information_screen.dart';
import 'package:again1/ui/posts/sections/faculty_screen.dart';
import 'package:again1/ui/posts/sections/sub_sections/events_calendar/events_calendar_screen.dart';
import 'package:again1/ui/posts/sections/scanner_screen.dart';
import 'package:again1/ui/posts/sections/feedback_reporting_screen.dart';
import 'package:again1/ui/posts/sections/sub_sections/ai/chat.dart';
import 'package:again1/ui/posts/sections/sub_sections/medicalcenter/medical_center.dart';
import 'package:again1/ui/posts/sections/sub_sections/settings/settings_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostItem> allItems = [
    PostItem(title: 'Navigation', imagePath: 'assets/images/gps.jpg', pageBuilder: () => NavigationScreen()),
    PostItem(title: 'Building Info', imagePath: 'assets/images/building.jpg', pageBuilder: () => BuildingInformationScreen()),
    PostItem(title: 'Faculty', imagePath: 'assets/images/faculty.jpg', pageBuilder: () => FacultyScreen()),
    PostItem(title: 'Events Calendar', imagePath: 'assets/images/events.jpg', pageBuilder: () => EventsCalendarScreen()),
    PostItem(title: 'Medical Center', imagePath: 'assets/images/emergency.png', pageBuilder: () => EmergencyAssistanceScreen()),
    PostItem(title: 'Transport ', imagePath: 'assets/images/transportt.jpg', pageBuilder: () => Transport()),
    PostItem(title: 'Scanner', imagePath: 'assets/images/scanner.jpg', pageBuilder: () => ScannerScreen()),
    PostItem(title: 'Virtual Assistant', imagePath: 'assets/images/ai.jpg', pageBuilder: () => VirtualAssistant()),
    PostItem(title: 'Feedback', imagePath: 'assets/images/feedback.png', pageBuilder: () => FeedbackReportingScreen()),
    PostItem(title: 'Settings', imagePath: 'assets/images/settings.png', pageBuilder: () => SettingsScreen()),
  ];

  List<PostItem> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    filteredItems.addAll(allItems);
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = allItems.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default pop
      onPopInvoked: (didPop) async {
        if (didPop) return;

        // If search field is not empty, just clear it
        if (searchController.text.isNotEmpty) {
          setState(() {
            searchController.clear();
            filteredItems = List.from(allItems);
          });
          return;
        }

        // Show exit dialog only when no search text (i.e., on "home")
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ?? false;

        if (shouldExit) {
          SystemNavigator.pop();
        }
      },

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: filterItems,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    children: filteredItems.map((item) => _buildGridItem(item)).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildGridItem(PostItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item.pageBuilder()),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Adjust corner radius as needed
                child: Image.asset(
                  item.imagePath,
                  height: 110,
                  width: 110,
                  fit: BoxFit.cover,
                ),
              ),

            ),
            SizedBox(height: 2), // Added space between image and text
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostItem {
  final String title;
  final String imagePath;
  final Widget Function() pageBuilder;

  PostItem({
    required this.title,
    required this.imagePath,
    required this.pageBuilder,
  });
}
