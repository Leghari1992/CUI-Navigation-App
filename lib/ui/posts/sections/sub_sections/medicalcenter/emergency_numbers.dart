import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatelessWidget {
  // Define your emergency contact numbers as final
  static final List<Map<String, String>> emergencyContacts = [
    {'title': 'Emergency Number 1', 'number': '15'}, // Emergency Number
    {'title': 'IGP Complaint Number', 'number': '1715'}, // IGP Complaint Number
    {'title': 'Fire Brigade Number', 'number': '16'}, // Fire Brigade Number
    {'title': 'Rescue Service Number', 'number': '1122'}, // Rescue Service Number
    {'title': 'PIMS Hospital Number', 'number': '051-9261170'}, // PIMS Hospital Number
    {'title': 'Polyclinic Hospital Number', 'number': '051-9214965'}, // Polyclinic Hospital Number
  ];

  const EmergencyNumbers({Key? key});

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Emergency Numbers', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: emergencyContacts.length,
          itemBuilder: (context, index) {
            final contact = emergencyContacts[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(contact['title']!),
                subtitle: Text(contact['number']!),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () => _makePhoneCall(contact['number']!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
