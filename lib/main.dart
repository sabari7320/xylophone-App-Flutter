import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import 'package:xylophone/xpp.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
FirebaseMessaging messaging = FirebaseMessaging.instance;
String? token = await messaging.getToken();
print('Firebase Messaging token: $token');
AwesomeNotifications().initialize(
  'resource://drawable/ic_launcher',
[
NotificationChannel(
channelKey: 'basic_channel',
channelName: 'Basic notifications',
channelDescription: 'Notification channel for basic tests',
defaultColor: Colors.green,
ledColor: Colors.white,

)
],
);

runApp(MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key});

@override
Widget build(BuildContext context) {
return MaterialApp(
home: Xylophone(),
);
}
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// Add a delay to allow the messaging service to connect to the application
await Future.delayed(Duration(seconds: 1));

// Handle FCM message in the background
AwesomeNotifications().createNotification(
content: NotificationContent(
id: message.notification.hashCode,
channelKey: 'basic_channel',
title: message.notification?.title ?? '',
body: message.notification?.body ?? '',

  bigPicture: 'https://picsum.photos/600/300',
  notificationLayout: NotificationLayout.BigPicture,
  largeIcon: 'https://picsum.photos/100',
),
);
}
