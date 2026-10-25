import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsListScreen extends StatefulWidget {
  @override
  _EventsListScreenState createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  Map<String, List<Map<String, String>>> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  bool isAuthenticated = false; // Flag to track user authentication

  @override
  void initState() {
    super.initState();
    loadEvents();
    checkAuthentication(); // Check authentication status
    _deleteOldEvents();
  }

  Future<void> checkAuthentication() async {
    // Implement your authentication check logic here
    // Example: Check if user is logged in or token is valid
    // For simplicity, we'll use a boolean flag
    isAuthenticated = true; // Replace with your authentication logic
    setState(() {}); // Refresh UI based on authentication status
  }

  Future<void> loadEvents() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('events').get();
    final events = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final DateTime eventDate =
      (data['eventDate'] as Timestamp).toDate();

      return {
        'id': doc.id,
        'eventDate': eventDate, // Store date as DateTime for sorting
        'eventTitle': data['eventTitle'] as String,
        'eventDescp': data['eventDescp'] as String,
      };
    }).toList();

    events.sort((a, b) {
      final DateTime aDate = a['eventDate'] as DateTime;
      final DateTime bDate = b['eventDate'] as DateTime;
      return aDate.compareTo(bDate);
    });

    setState(() {
      mySelectedEvents.clear(); // Clear previous data before updating
      for (var event in events) {
        final date = DateFormat('d MMMM yyyy').format(event['eventDate'] as DateTime);
        final eventData = {
          'id': event['id'] as String,
          'eventTitle': event['eventTitle'] as String,
          'eventDescp': event['eventDescp'] as String,
        };
        if (mySelectedEvents[date] != null) {
          mySelectedEvents[date]!.add(eventData);
        } else {
          mySelectedEvents[date] = [eventData];
        }
      }
    });
  }


  Future<void> _deleteOldEvents() async {
    final today = DateTime.now();
    final fifteenDaysAgo = today.subtract(Duration(days: 15));

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('eventDate', isLessThan: Timestamp.fromDate(fifteenDaysAgo))
        .get();

    final batch = FirebaseFirestore.instance.batch();
    snapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    await batch.commit();
  }

  Future<void> _showEditEventDialog(
      String eventId, Map<String, String> event) async {
    titleController.text = event['eventTitle']!;
    descpController.text = event['eventDescp']!;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: isAuthenticated // Check authentication status
                ? () async {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              final updatedData = {
                'eventTitle': titleController.text,
                'eventDescp': descpController.text,
              };

              await FirebaseFirestore.instance
                  .collection('events')
                  .doc(eventId)
                  .update(updatedData);

              setState(() {
                event['eventTitle'] = titleController.text;
                event['eventDescp'] = descpController.text;
              });

              titleController.clear();
              descpController.clear();
              Navigator.pop(context);
            }
                : null,
            child:
            const Text('Update Event'), // Disable button if not authenticated
          )
        ],
      ),
    );
  }

  Future<void> _deleteEvent(String eventId, Map<String, String> event) async {
    if (!isAuthenticated) {
      // Show a message indicating authentication is required
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must be authenticated to delete events.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Delete the event from Firestore
      await FirebaseFirestore.instance.collection('events').doc(eventId).delete();

      // Reload events to reflect deletion
      await loadEvents();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Event deleted successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting event: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event List',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: mySelectedEvents.keys.length,
        itemBuilder: (context, index) {
          final date = mySelectedEvents.keys.elementAt(index);
          final events = mySelectedEvents[date]!;
          return ExpansionTile(
            title: Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: events.map((event) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event Title: ${event['eventTitle']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Description: ${event['eventDescp']}'),
                    SizedBox(height: 8),
                    Text('Date: $date'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _showEditEventDialog(event['id']!, event),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              _deleteEvent(event['id']!, event),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }
}