import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nn_portal/firebase_options.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/presentation/screens/home.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

initializeNotifications() async {
  getFirebaseMessagingToken();
  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}

Future<String?> getFirebaseMessagingToken() async {
  String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
  print("firebase token $firebaseMessagingToken");

  return firebaseMessagingToken;
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

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
      onSelectNotification: (payload) {
    print('onSelectNotification $payload');
    if (payload != null) {
      // Map<String, dynamic> messageData = json.decode(payload);
      //
      // notificationAction(messageData, 0);
    }
  });

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  print('message ${message.data}');
  print('message ${message.notification!.body}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
      payload: json.encode(message.data),
    );
  }
}

Future<dynamic> selectNotification(String payload) async {
  print('notification  selectNotification');
  print(payload);
  if (payload.isNotEmpty) {
    Map<String, dynamic> messageData = json.decode(payload);

    notificationAction(messageData, 0);
  }
}

notificationAction(Map<String, dynamic> messageData, int delay) async {
  Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => const Home(),
      ),
      (route) => false);
}
