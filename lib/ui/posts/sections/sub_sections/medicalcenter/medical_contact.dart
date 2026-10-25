import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalContact {
  final String title;
  final String number;

  MedicalContact({required this.title, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'number': number,
    };
  }
}

class MedicalNumbers extends StatelessWidget {
  final List<Map<String, dynamic>> clinicalPsychologistContacts = [
    {'title': 'Contact 1', 'number': '051-90495369'},
    {'title': 'Contact 2', 'number': '051-90495777'},
    {'title': 'Contact 3', 'number': '051-90495555'},
  ];

  final List<Map<String, dynamic>> ambulanceContacts = [
    {'title': 'Ambulance 1', 'number': '0330-5178358'},
    {'title': 'Ambulance 2', 'number': '0332-3005111'},
  ];

  final List<Map<String, dynamic>> emergencyMedicalContacts = [
    {'title': 'Contact 1', 'number': '0332-3005777'},
    {'title': 'Contact 2', 'number': '051-90495777'},
    {'title': 'Contact 3 (Ext.)', 'number': '5777'},
  ];

  final List<Map<String, dynamic>> emergencySecurityContacts = [
    {'title': 'Contact 1', 'number': '0332-3005888'},
    {'title': 'Contact 2', 'number': '051-90495888'},
    {'title': 'Contact 3 (Ext.)', 'number': '5888'},
  ];

  final CollectionReference clinicalPsychologistCollection =
  FirebaseFirestore.instance.collection('clinicalPsychologistContacts');
  final CollectionReference ambulanceCollection =
  FirebaseFirestore.instance.collection('ambulanceContacts');
  final CollectionReference emergencyMedicalCollection =
  FirebaseFirestore.instance.collection('emergencyMedicalContacts');
  final CollectionReference emergencySecurityCollection =
  FirebaseFirestore.instance.collection('emergencySecurityContacts');

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> addContact(CollectionReference collection, String title, String number) async {
    final querySnapshot = await collection
        .where('title', isEqualTo: title)
        .where('number', isEqualTo: number)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await collection.add({
        'title': title,
        'number': number,
      });
    }
  }

  Future<void> updateContact(CollectionReference collection, String docId, String title, String number) async {
    await collection.doc(docId).update({
      'title': title,
      'number': number,
    });
  }

  Future<void> deleteContact(CollectionReference collection, String docId) async {
    await collection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    // Add initial contacts to Firestore only once
    _addAllContactsOnce(clinicalPsychologistCollection, clinicalPsychologistContacts);
    _addAllContactsOnce(ambulanceCollection, ambulanceContacts);
    _addAllContactsOnce(emergencyMedicalCollection, emergencyMedicalContacts);
    _addAllContactsOnce(emergencySecurityCollection, emergencySecurityContacts);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Medical Contacts', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Only Admins can add, update, delete contacts',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              _buildContactsSection(context, 'Clinical Psychologist Contacts', clinicalPsychologistCollection),
              _buildContactsSection(context, 'Ambulance Contacts', ambulanceCollection),
              _buildContactsSection(context, 'Emergency Medical Unit', emergencyMedicalCollection),
              _buildContactsSection(context, 'Emergency Security Unit', emergencySecurityCollection),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildContactsSection(BuildContext context, String sectionTitle, CollectionReference collection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                sectionTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _showAddDialog(context, collection),
            ),
          ],
        ),
        SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: collection.orderBy('title').snapshots(),  // Order by title
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final contact = documents[index];
                final data = contact.data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(data['title']),
                    subtitle: Text(data['number']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, size: 15),
                          onPressed: () {
                            _showEditDialog(context, collection, contact.id, data['title'], data['number']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 15),
                          onPressed: () {
                            deleteContact(collection, contact.id);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.call, size: 25),
                          onPressed: () => _makePhoneCall(data['number']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }


  Future<void> _addAllContactsOnce(CollectionReference collection, List<Map<String, dynamic>> contacts) async {
    // Add all contacts from the list to Firestore only if they don't exist
    for (var contact in contacts) {
      await addContact(collection, contact['title'], contact['number']);
    }
  }

  Future<void> _showAddDialog(BuildContext context, CollectionReference collection) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController numberController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                addContact(collection, titleController.text, numberController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(BuildContext context, CollectionReference collection, String docId, String currentTitle, String currentNumber) async {
    TextEditingController titleController = TextEditingController(text: currentTitle);
    TextEditingController numberController = TextEditingController(text: currentNumber);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                updateContact(collection, docId, titleController.text, numberController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
