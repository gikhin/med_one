import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late FirebaseMessaging _messaging;
  String? _notificationTitle = "No Notifications Yet";
  String? _notificationBody = "";

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Request notification permissions (required for iOS)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permission granted: ${settings.authorizationStatus}');

    // Get the FCM token for this device
    _messaging.getToken().then((String? token) {
      print("FCM Token: $token");
      // Send the token to your backend server for notification targeting
    });

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      setState(() {
        _notificationTitle = message.notification?.title;
        _notificationBody = message.notification?.body;
      });
      _showNotificationDialog(
        message.notification?.title ?? "No Title",
        message.notification?.body ?? "No Body",
      );
    });

    // Listen for messages when the app is opened from the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked! Title: ${message.notification?.title}");
      setState(() {
        _notificationTitle = message.notification?.title;
        _notificationBody = message.notification?.body;
      });
    });
  }

  void _showNotificationDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notification Title:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_notificationTitle ?? ""),
            SizedBox(height: 16),
            Text(
              'Notification Body:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_notificationBody ?? ""),
          ],
        ),
      ),
    );
  }
}