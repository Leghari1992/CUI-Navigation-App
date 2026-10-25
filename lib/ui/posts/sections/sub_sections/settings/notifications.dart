import 'dart:math';
import 'package:again1/ui/posts/sections/sub_sections/settings/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationsServices notificationsServices = NotificationsServices();

  @override
  void initState() {
    super.initState();
    notificationsServices.requestNotificationPermission();
    notificationsServices.firebaseInit(context);
    notificationsServices.isTokenRefresh();
    notificationsServices.getDeviceToken().then((value) {
      print('Device token: $value');
      notificationsServices.storeDeviceToken(value); // Store device token in Firestore
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<bool>(
        future: notificationsServices.getNotificationPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading notification preference'));
          } else {
            bool notificationsEnabled = snapshot.data ?? true;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Icon(
                      notificationsEnabled
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      size: 100,
                      color: Colors.indigo,
                    ),
                    SizedBox(height: 16),
                    Text(
                      notificationsEnabled
                          ? 'Notifications Enabled'
                          : 'Notifications Disabled',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      notificationsEnabled
                          ? 'You have enabled notifications for this app. To disable notifications, use the toggle below.'
                          : 'You have disabled notifications for this app. To enable notifications, use the toggle below.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    SwitchListTile(
                      title: Text('Enable Notifications'),
                      value: notificationsEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          notificationsServices.setNotificationPreference(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}




// Your NotificationsServices class here
class NotificationsServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = true;

  NotificationsServices() {
    _loadNotificationPreference();
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  void initLocalNotifications() async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        final payload = notificationResponse.payload;
        if (payload != null) {
          print('Notification payload: $payload');
          // Handle navigation or other actions
        }
      },
    );
  }
  void firebaseInit(BuildContext context) {
    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && message.notification?.title != null && message.notification?.body != null) {
        showNotification(message, 0); // Use a fixed notification ID to avoid duplication
      }
    });

    // Handle notification tap (when the app is opened from the background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification caused app to open from terminated state');
      handleNotificationTap(message);
    });

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message: ${message.messageId}');

    // Check if the notification was already shown (to avoid duplicates)
    if (message.notification != null && message.notification?.title != null && message.notification?.body != null) {
      NotificationsServices().showNotification(message, 0); // Show with same ID to avoid duplication
    }
  }

  Future<void> showNotification(RemoteMessage message, int notificationId) async {
    if (notificationsEnabled && message.notification?.title != null && message.notification?.body != null) {
      // Initialize the notification channel
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'CUI Guide Notifications',
        importance: Importance.max,
      );

      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'Comsats CUI Guide Notification',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher', // Ensure small icon is set
      );

      NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

      // Show notification with the same ID to avoid duplicates
      await _flutterLocalNotificationsPlugin.show(
        notificationId, // Fixed ID ensures only one notification per message
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        notificationDetails,
        payload: message.data['payload'], // Use payload if available
      );
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((String newToken) {
      print('Token refreshed: $newToken');
      storeDeviceToken(newToken); // Update token in Firestore
    });
  }

  void storeDeviceToken(String token) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      await firestore.collection('device_tokens').doc(userId).set({
        'token': token,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        print('Device token stored in Firestore');
      }).catchError((error) {
        print('Failed to store device token: $error');
      });
    } else {
      print('No user is currently signed in');
    }
  }

  void handleNotificationTap(RemoteMessage message) {
    // Implement navigation or other actions based on the notification data
    print('Handling notification tap with data: ${message.data}');
    // Example: Navigate to a specific screen
  }

  Future<bool> getNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }

  void _loadNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
  }

  void setNotificationPreference(bool enabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications_enabled', enabled);
    notificationsEnabled = enabled;
  }
}
