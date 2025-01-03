import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils.dart';
// Define the background message handler as a top-level function
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;



  // Function to save the FCM token to SharedPreferences
  Future<void> saveTokenToPreferences(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', token);
    print('hehfeiiedif');
    print('hehehehheheehehe:${prefs.getString('fcmToken')}');
  }

  // Update this method to save the token to SharedPreferences
  void fetchAndSendToken() async {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      sendTokenToServer(token);
      await saveTokenToPreferences(token); // Save token locally
    }
  }



  final _androidChannel = const AndroidNotificationChannel(

    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  // void handleMessage(RemoteMessage? message) {
  //   if (message == null) return;
  //
  //   navigatorKey.currentState?.pushNamed(
  //     NotificationScreen.route,
  //     arguments: message,
  //   );
  // }

  Future initLocalNotifications() async {
    const darwin = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: darwin);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final Map<String, dynamic> messageData = jsonDecode(response.payload!);
          final message = RemoteMessage.fromMap(messageData);
          print('checking001:$message');
          // handleMessage(message);
        }
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    await initPushNotifications();
    initLocalNotifications();
    Utils.sendfcmtoken('${fCMToken}');
  }



// Function to send token to your server
  void sendTokenToServer(String token) {
    Utils.sendfcmtoken(token);
    // Replace this with your API call to send the token to your backend server
    print("Sending token to server: $token");
  }
}
