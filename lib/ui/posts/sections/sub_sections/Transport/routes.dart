import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoutesScreen extends StatefulWidget {
  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController routeNoController = TextEditingController();
  final TextEditingController stopsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uploadRoutes();
  }

  Future<void> uploadRoutes() async {
    User? user = auth.currentUser;
    if (user == null) {
      user = (await auth.signInAnonymously()).user;
    }

    final List<Map<String, dynamic>> routes = [
      {
        'routeNo': 'Route No 1',
        'stops': [
          '1. F-11 Markaz Hamza Chowk',
          '2. F-11 Khokha Stop',
          '3. F-11 Goura More',
          '4. F-11 Signal (Main Margalla Road)',
          '5. F-11 Jugnu Stop',
          '6. F-11 Service Road',
          '7. F-10 Round About, Sumbal Road',
          '8. F-9 DCI',
          '9. F-9 PAF Complex Gate',
          '10. F-9 Shaheen Chowk',
          '11. F-8/F-8 Madina Market',
          '12. Zafar Chowk',
          '13. F-11/F-10 Double Signal',
          '14. F-7/F-7 Faisal Chowk',
          '15. F-7 Rana Market',
          '16. F-7 Parbat Road Signal',
          '17. F-6 Flower Market',
          '18. F-6 Press Club',
          '19. Poly Clinic',
          '20. Lal Masjid Chowk',
          '21. G-6 Street No 56',
        ],
      },
      {
        'routeNo': 'Route No 2',
        'stops': [
          '1. G-11/2 Apple School',
          '2. G-11 Markaz (Signal Stop)',
          '3. G-11/3 Allah din Apartment',
          '4. G-10/G-11 Round About',
          '5. G-10 Umer Market',
          '6. G-10 Buland Markaz',
        ],
      },
      {
        'routeNo': 'Route No 3',
        'stops': [
          '1. G-10/3-4 Signal',
          '2. G-9/1 Street No 44',
          '3. G-9 Markaz/GPO',
          '4. G-9 Alfalah Bank',
          '5. G-9 Qazafi Chowk',
          '6. G-9 Bohar Masjid',
          '7. G-8/1 Flats/Markaz',
          '8. G-8 Jhelum Road',
          '9. G-8 Noori Gate',
          '10. G-8/1 Round about',
          '11. G-7 Bank Colony',
          '12. G-7 Sitara Market',
          '13. G-7 Iqbal Hall',
          '14. G-6/1-2 Stop',
          '15. G-6/1 Street 34 & Lal Masjid',
          '16. G-6 Abpara',
          '17. G-6 Street 36',
          '18. Serena Hotel',
        ],
      },
      {
        'routeNo': 'Route No 4',
        'stops': [
          '1. I-8/3, Signal',
          '2. I-8/3 College Road',
          '3. I-8 Markaz',
          '4. I-8/4 Street No 85',
          '5. I-8/4 Tanki Stop',
          '6. WAPDA Flats',
          '7. I-8/1 Fruit Stop',
          '8. I-8/2 Street No 85',
          '9. I-8/2 street No 35',
          '10. Faiz Ahmed Faiz',
          '11. I-9 School Stop',
          '12. I-9 Street No 37',
          '13. Ali Medical',
          '14. I-9 Java Hotel',
          '15. I-9 Street No 18',
          '16. I-9/1 SUI Gas Chowk',
        ],
      },
      {
        'routeNo': 'Route No 5',
        'stops': [
          '1. I-10/4  Street No 30',
          '2. I-10/1 Street No 23',
          '3. I-10 Tanki Stop',
          '4. I-10 Markaz',
          '5. I-10/2 Street No 10',
          '6. I-10/2 Street No 32A',
          '7. I-10/2 Street No 57',
          '8. Mandi Mor',
          '9. I-10/2 O.H Bridge',
          '10. I-10/2 Coolar Stop',
          '11. I-10/1 Near Street No 14',
          '12. I-10 CDA Stop',
          '13. I-10/4 IJP (2nd) O/H Bridge IJP',
          '14. Pindora Chungi',
          '15. Double Road',
        ],
      },
      {
        'routeNo': 'Route No 6',
        'stops': [
          '1. National Market',
          '2. Kali Tanki',
          '3. Haider Chowk',
          '4. College Chowk',
          '5. Siddique Chowk',
          '6. Katarian Chowk',
          '7. Katarian Chungi',
        ],
      },
      {
        'routeNo': 'Route No 7',
        'stops': [
          '1. Faizabad',
          '2. Shamsabad',
          '3. 6th Road',
          '4. Rehmanabad',
          '5. Sadiaqabad',
          '6. Chandni Chowk',
          '7. Islamic Center',
          '8. Center Hospital',
          '9. Naz Cinema',
          '10. Waris Khan',
          '11. CNG Stop',
          '12. Committee Chowk',
          '13. LIAQAT Bagh',
          '14. Medical College',
          '15. Sir Syed Chowk',
          '16. Mashid Stop',
          '17. Fauji Tower',
        ],
      },
      {
        'routeNo': 'Route No 8',
        'stops': [
          '1. EME College',
          '2. Motorway Chowk',
          '3. 26 Number Stop',
          '4. G-15 (Main Gate)',
          '5. G-14 Kashmir Highway',
          '6. G-13 (IBA Chowk)',
          '7. G-13 Markaz',
          '8. PSO Pump (Near Nust Gate)',
        ],
      },
      {
        'routeNo': 'Route No 9',
        'stops': [
          '1. Golra More',
          '2. Hajj Complex',
          '3. Chishti Abad',
          '4. KOH-E-NOOR Mill Stop',
          '5. Old Daewoo Stop',
          '6. Kainat Travel',
          '7. Under Pass',
          '8. Choor Chowk',
          '9. Lane No 5',
          '10. Charing Cross',
          '11. Valley Road',
        ],
      },
      {
        'routeNo': 'Route No 10',
        'stops': [
          '1. 502 Workshop',
          '2. Dheri Hasanabad',
          '3. M.H',
          '4. Chungi No 22',
          '5. Askari Xi',
          '6. Jhanda Chichi',
          '7. Qasim Market',
          '8. Roomi Park',
          '9. G.P.O Saddar',
        ],
      },
      {
        'routeNo': 'Route No 11',
        'stops': [
          '1. Biscuit Factory Chowk',
          '2. Quaid-e-Azam Colony (Lane No 1)',
          '3. Ahmadabad',
          '4. Jhawra',
          '5. WAPDA Gate',
          '6. Kalma Chowk',
          '7. Shaheen CNG (PICK ONLY)',
          '8. Kachehri Chowk',
        ],
      },
      {
        'routeNo': 'Route No 12',
        'stops': [
          '1. Askari XIV',
          '2. Gulshanabad Markaz',
          '3. Gulshanabad Gate',
          '4. Sanjoli State Colony',
          '5. Jarie Stop',
          '6. Gillani Mart',
          '7. Munawar Colony',
          '8. AL-Habib Bakers',
          '9. Khawja Coporation',
          '10. Askari VII',
          '11. New Lalazar',
        ],
      },
      {
        'routeNo': 'Route No 13',
        'stops': [
          '1. DHA Gate No 2/3',
          '2. DHA Gate No 1',
          '3. Sehala More',
          '4. Toyota Motors',
          '5. High Court Sawan Ada (Main Stop)',
          '6. DHA No.1/Fauji Foundation',
          '7. Al-Shifa Hospital',
          '8. Morgah More',
          '9. New Lalazar',
        ],
      },
      {
        'routeNo': 'Route No 14',
        'stops': [
          '1.  Rawat Main Stop',
          '2. Khokhar Plaza Rawat',
          '3. T-Chowk',
          '4. DHA Gate No 7',
          '5. KAK Pull',
          '6. Bhander',
          '7. Naval Anchorage',
          '8. Sowan Garden',
        ],
      },
      {
        'routeNo': 'Route No 15',
        'stops': [
          '1. Media Town',
          '2. Bahria Town Ace Academy',
          '3. Street No 6',
          '4. Bahria More',
          '5. Al-Noor Pharmacy',
          '6. DULUX Beauty Parlour',
        ],
      },
      {
        'routeNo': 'Route No 16',
        'stops': [
          '1. London Bakery',
          '2. Rahat Bakery',
          '3. P.W.D Barrier',
          '4. Pakistan Town',
          '5. Gulberg Stop',
        ],
      },
      {
        'routeNo': 'Route No 17',
        'stops': [
          '1. Bilal Shaheed Chowk',
          '2. Askari 1',
          '3. Askari 5',
          '4. Askari 2',
          '5. Askari 3',
          '6. Ammar Chowk',
          '7. Rahamabad',
          '8. Airport Signal Stop',
          '9. Shah Khalid Colony',
          '10. Fazal Town',
          '11. Gulzar-e-Quaid',
        ],
      },
      {
        'routeNo': 'Route No 18',
        'stops': [
          '1. Gangal East',
          '2. Karal Chowk',
          '3. Gangal West',
          '4. Fizaia Colony',
          '5. TCS Service Road',
          '6. Chattry Chowk',
          '7. Khanna Pull',
          '8. Mizail Chowk',
          '9. Kuri Road Highway Stop',
          '10. Iqbal Town',
          '11. Dhok Kala Khan',
        ],
      },
      {
        'routeNo': 'Route No 19',
        'stops': [
          '1. 17 Meel Stop',
          '2. Shah Pur',
          '3. Bara Kahu',
          '4. Abbasi Hotel',
          '5. Malpur',
          '6. Bari Imam Chowk',
          '7. Kashmir Chowk',
          '8. Margala Town (Service Road)',
          '9. Rawal Dam',
        ],
      },
    ];

    for (var route in routes) {
      final QuerySnapshot result = await firestore
          .collection('routes')
          .where('routeNo', isEqualTo: route['routeNo'])
          .get();

      if (result.docs.isEmpty) {
        await firestore.collection('routes').add(route);
      }
    }
  }

  Future<void> addRoute(String routeNo, List<String> stops) async {
    await firestore.collection('routes').add({
      'routeNo': routeNo,
      'stops': stops,
    });
  }

  Future<void> updateRoute(String id, String routeNo, List<String> stops) async {
    await firestore.collection('routes').doc(id).update({
      'routeNo': routeNo,
      'stops': stops,
    });
  }

  Future<void> deleteRoute(String id) async {
    await firestore.collection('routes').doc(id).delete();
  }

  void showRouteDialog({DocumentSnapshot? route}) {
    if (route != null) {
      routeNoController.text = route['routeNo'];
      stopsController.text = (route['stops'] as List<dynamic>).join(', ');
    } else {
      routeNoController.clear();
      stopsController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(route != null ? 'Edit Route' : 'Add Route'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: routeNoController,
                decoration: InputDecoration(labelText: 'Route Number'),
              ),
              TextField(
                controller: stopsController,
                decoration: InputDecoration(labelText: 'Stops (comma separated)'),
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
                final routeNo = routeNoController.text;
                final stops = stopsController.text.split(',').map((e) => e.trim()).toList();
                if (route != null) {
                  updateRoute(route.id, routeNo, stops);
                } else {
                  addRoute(routeNo, stops);
                }
                Navigator.of(context).pop();
              },
              child: Text(route != null ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text('Routes', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('routes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final routesData = snapshot.data!.docs;
          routesData.sort((a, b) {
            int routeNoA = int.parse(a['routeNo'].split(' ')[2]);
            int routeNoB = int.parse(b['routeNo'].split(' ')[2]);
            return routeNoA.compareTo(routeNoB);
          });

          return ListView.builder(
            itemCount: routesData.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Only Admins can add, update, delete contacts',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.red,),
                  ),
                );
              }
              final route = routesData[index - 1];
              final stops = List<String>.from(route['stops']);

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(route['routeNo']),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, size: 18),
                            onPressed: () => showRouteDialog(route: route),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 18),
                            onPressed: () => deleteRoute(route.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stops.map((stop) => Text(stop)).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showRouteDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

}
