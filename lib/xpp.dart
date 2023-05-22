import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'main.dart';

class Xylophone extends StatefulWidget {
  const Xylophone({Key? key}) : super(key: key);

  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  final FirebaseMessagingService _messagingService = FirebaseMessagingService();

  void playSound(int soundNUmber) {
    final player = AudioPlayer();
    player.play(AssetSource('note$soundNUmber.wav'));
  }

  Expanded buildkey({required Color color, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: () {
          playSound(soundNumber);
        },
        child: Text(''),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _messagingService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildkey(color: Colors.red, soundNumber: 1),
              buildkey(color: Colors.orange, soundNumber: 2),
              buildkey(color: Colors.yellowAccent, soundNumber: 3),
              buildkey(color: Colors.green, soundNumber: 4),
              buildkey(color: Colors.teal, soundNumber: 5),
              buildkey(color: Colors.blue, soundNumber: 6),
              buildkey(color: Colors.purple, soundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission to show notifications
    await _messaging.requestPermission();

    // Add foreground message handler
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show notification
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
}
