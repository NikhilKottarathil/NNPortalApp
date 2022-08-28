import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nn_portal/main.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings();
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (s) => selectNotification);

  setupInteractedMessage(MyApp.navigatorKey.currentContext!);

  getFirebaseMessagingToken();
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  displayMessage(message);
}

AndroidNotificationChannel androidNotificationChannel =
    const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);


Future<String> getFirebaseMessagingToken() async {
  String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
  print('fcm : ${firebaseMessagingToken!}');
  return firebaseMessagingToken;
}

Future<dynamic> selectNotification(String payload) async {
  print('notification  selectNotification');
  print(payload);
  if (payload.isNotEmpty) {
    Map<String, dynamic> messageData = json.decode(payload);

    notificationAction(messageData, 0);
  }
}

Future<void> setupInteractedMessage(BuildContext context) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    displayMessage(message);
  });

  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    print('notification  initialMessage');
    if (message != null) {
      Map<String, dynamic> messageData = message.data;

      notificationAction(messageData, 2);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('notification  onMessageOpenedApp');
    if (message != null) {
      Map<String, dynamic> messageData = message.data;

      notificationAction(messageData, 1);
    }
  });
}

Future<void> displayMessage(RemoteMessage message) async {


  print('notification onMessage');
  print(message.notification);
  print(message.data);

  if (message.data['type'] == 'message_room') {
    flutterLocalNotificationsPlugin.show(
      0,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: json.encode(message.data),
    );
  }
}

notificationAction(Map<String, dynamic> messageData, int delay) async {
  if (messageData['type'] != null) {
    String messageType = messageData['type'];
    if (messageType == 'message_room') {
      Navigator.pushNamed(
        MyApp.navigatorKey.currentContext!,
        '/messageRoom',
      );
    }
  }
}
