import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    uploadContacts();
  }

  Future<void> uploadContacts() async {
    // Example contacts data
    final List<Map<String, dynamic>> driverscontacts = [
      {'title': 'Route 1', 'name': 'Mr.M.Javed', 'number': '0303-2601912'},
      {'title': 'Route 2', 'name': 'Mr.M.Khan', 'number': '0347-874498'},
      {'title': 'Route 3', 'name': 'Hafiz Umer', 'number': '0306-6283188'},
      {'title': 'Route 4', 'name': 'Mr.Ilyas Masih', 'number': '0346-5307639'},
      {'title': 'Route 5', 'name': 'Mr.Ghulam Shabir', 'number': '0344-3345504'},
      {'title': 'Route 6', 'name': 'Mr.Faisal Akbar', 'number': '0345-5310763'},
      {'title': 'Route 7', 'name': 'Mr.M.Akmal', 'number': '0333-8766422'},
      {'title': 'Route 8', 'name': 'Mr.Ali raza', 'number': '0331-5449014'},
      {'title': 'Route 9', 'name': 'Mr.Ghul Maan Shah', 'number': '0344-9167991'},
      {'title': 'Route 10', 'name': 'Mr.M.Asif', 'number': '0342-8652143'},
      {'title': 'Route 11', 'name': 'Mr.Javed Iqbal', 'number': '0308-8514486'},
      {'title': 'Route 12', 'name': 'Mr.Yasir', 'number': '0342-5021908'},
      {'title': 'Route 13', 'name': 'Muzamil Shahzad', 'number': '0344-6871194'},
      {'title': 'Route 14', 'name': 'Malik Amjad', 'number': '0331-5023397'},
      {'title': 'Route 15', 'name': 'Mr.Faisal Masih', 'number': '0312-5888048'},
      {'title': 'Route 16', 'name': 'Mr.Saqib-ur-Rehman', 'number': '0309-5616084'},
      {'title': 'Route 17', 'name': 'Mr.Mudasir Hussain', 'number': '0341-5893994'},
      {'title': 'Route 18', 'name': 'Mr.M.Imran', 'number': '0343-4974599'},
      {'title': 'Route 19', 'name': 'Mr.M.Shahzad', 'number': '0306-5258214'},
    ];

    // Upload each contact if it doesn't already exist
    for (var contact in driverscontacts) {
      final QuerySnapshot result = await firestore
          .collection('driverscontacts')
          .where('title', isEqualTo: contact['title'])
          .where('name', isEqualTo: contact['name'])
          .get();

      if (result.docs.isEmpty) {
        await firestore.collection('driverscontacts').add(contact);
      }
    }
  }

  Future<void> deleteContact(String id) async {
    await firestore.collection('driverscontacts').doc(id).delete();
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void showContactDialog({DocumentSnapshot? contact}) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();

    if (contact != null) {
      titleController.text = contact['title'];
      nameController.text = contact['name'];
      numberController.text = contact['number'];
    } else {
      titleController.clear();
      nameController.clear();
      numberController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(contact != null ? 'Edit Contact' : 'Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final name = nameController.text;
                final number = numberController.text;
                if (contact != null) {
                  updateContact(contact.id, title, name, number);
                } else {
                  addContact(title, name, number);
                }
                Navigator.of(context).pop();
              },
              child: Text(contact != null ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addContact(String title, String name, String number) async {
    await firestore.collection('driverscontacts').add({
      'title': title,
      'name': name,
      'number': number,
    });
  }

  Future<void> updateContact(String id, String title, String name, String number) async {
    await firestore.collection('driverscontacts').doc(id).update({
      'title': title,
      'name': name,
      'number': number,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text('Drivers Contacts', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('driverscontacts').orderBy('title', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final contactsData = snapshot.data!.docs;

          // Sort contacts by extracting the route number and sorting numerically
          contactsData.sort((a, b) {
            int routeA = int.parse(a['title'].replaceAll('Route ', ''));
            int routeB = int.parse(b['title'].replaceAll('Route ', ''));
            return routeA.compareTo(routeB);
          });

          return ListView.builder(
            itemCount: contactsData.length + 2, // +2 for Note and FAB
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Only Admins can add, update, delete contacts',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.red,),
                  ),
                );
              } else if (index == contactsData.length + 1) {
                return SizedBox(height: 72); // Add space equivalent to the FAB height
              }

              final contact = contactsData[index - 1];

              return Padding(
                padding: EdgeInsets.only(bottom: index == contactsData.length ? 30 : 0), // Add bottom padding only to the last item
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      contact['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact['name'],
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          contact['number'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, size: 15),
                          onPressed: () => showContactDialog(contact: contact),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, size: 15),
                          onPressed: () => deleteContact(contact.id),
                        ),
                        IconButton(
                          icon: Icon(Icons.call, size: 25),
                          onPressed: () => _makePhoneCall(contact['number']),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showContactDialog(),
        child: Icon(Icons.add),
      ),
    );
  }


}
