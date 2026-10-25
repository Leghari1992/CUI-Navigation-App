import 'package:again1/ui/posts/sections/sub_sections/events_calendar/events_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsCalendarScreen extends StatefulWidget {
  const EventsCalendarScreen({super.key});

  @override
  State<EventsCalendarScreen> createState() => _EventsCalendarScreenState();
}

class _EventsCalendarScreenState extends State<EventsCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List<Map<String, String>>> mySelectedEvents = {};
  final titleController = TextEditingController();
  final descpController = TextEditingController();

  bool isAuthenticated = false; // Flag to track user authentication

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    loadPreviousEvents();
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

  Future<void> loadPreviousEvents() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('events').get();
    final events = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final DateTime eventDate = (data['eventDate'] as Timestamp).toDate();

      return {
        'id': doc.id,
        'eventDate': eventDate.toString(), // Store date as String for sorting
        'eventTitle': data['eventTitle'] as String,
        'eventDescp': data['eventDescp'] as String,
      };
    }).toList();

    events.sort((a, b) {
      final DateTime aDate = DateTime.parse(a['eventDate']!);
      final DateTime bDate = DateTime.parse(b['eventDate']!);
      return aDate.compareTo(bDate);
    });

    setState(() {
      for (var event in events) {
        final date = DateFormat('dd MMMM, yyyy').format(DateTime.parse(event['eventDate']!));
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



  List<Map<String, String>> _listOfDayEvents(DateTime dateTime) {
    final formattedDate = DateFormat('dd MMMM, yyyy').format(dateTime);
    return mySelectedEvents[formattedDate] ?? [];
  }



  Future<void> _showAddEventDialog() async {
    if (!isAuthenticated) {
      return; // Or show a message indicating authentication is required
    }
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
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

              final eventDate = _selectedDate!;
              final eventData = {
                'eventTitle': titleController.text,
                'eventDescp': descpController.text,
                'eventDate': Timestamp.fromDate(eventDate),
              };

              await FirebaseFirestore.instance
                  .collection('events')
                  .add(eventData);
              // Refresh events

              setState(() {
                final formattedDate =
                DateFormat('dd MMMM, yyyy').format(eventDate);
                // Ensure mySelectedEvents[formattedDate] is initialized
                if (mySelectedEvents[formattedDate] != null) {
                  mySelectedEvents[formattedDate]!.add({
                    'eventTitle': titleController.text,
                    'eventDescp': descpController.text,
                  });
                } else {
                  mySelectedEvents[formattedDate] = [
                    {
                      'eventTitle': titleController.text,
                      'eventDescp': descpController.text,
                    }
                  ];
                }
              });

              titleController.clear();
              descpController.clear();
              Navigator.pop(context);
            }
                : null,
            child:
            const Text('Add Event'), // Disable button if not authenticated
          )
        ],
      ),
    );
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events Calendar', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Center(
              child: Text(
                'Welcome to Events Calendar!',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 8), // Add some spacing between the welcome text and the description
            Center(
              child: Text(
                'Stay up-to-date with the latest events and activities.',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Buttons for changing calendar format
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarFormat = CalendarFormat.month;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  ),// Text color
                  child: Text('Month'),
                ),
                ElevatedButton(

                  onPressed: () {
                    setState(() {
                      _calendarFormat = CalendarFormat.twoWeeks;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  ),// Text color
                  child: Text('2 Weeks'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _calendarFormat = CalendarFormat.week;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                  ),// Text color
                  child: Text('Week'),
                ),
              ],
            ),

            SizedBox(height: 20.0),

            // Calendar Widget
            TableCalendar(
              firstDay: DateTime(2024),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: _calendarFormat, // Ensure _calendarFormat is used here
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _listOfDayEvents,
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


            SizedBox(height: 20.0),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Only Admins can add, update, delete events',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  if (isAuthenticated)
                    ElevatedButton(
                      onPressed: () => _showAddEventDialog(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: const Text("Add Event"),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventsListScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text("View Events"),
                  ),

                ],
              ),
            ),

            SizedBox(height: 20.0),
          ],
        ),
      ),

    );
  }

}


