import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nn_portal/firebase_options.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/presentation/screens/home.dart';
import 'package:nn_portal/presentation/screens/job_details.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }

initializeNotifications() async {
  getFirebaseMessagingToken();
await  Future.delayed(Duration(seconds: 5));
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  print('nnotification  initialMessage $initialMessage');

  if (initialMessage != null) {
    notificationAction(initialMessage.data, 3);
  }
  FirebaseMessaging.onMessage.listen((message){
    print('showFlutterNotification onmessage ');
    showFlutterNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('nnotification  onMessageOpenedApp $message');

    notificationAction(message.data, 1);
  });

  // FirebaseMessaging.instance
  //     .getInitialMessage()
  //     .then((RemoteMessage? message) async {
  //   print('notification  initialMessage');
  //   if (message != null) {
  //     Map<String, dynamic> messageData = message.data;
  //
  //     notificationAction(messageData, 2);
  //   }
  // });

}

Future<String?> getFirebaseMessagingToken() async {
  String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
  print("firebase token $firebaseMessagingToken");

  return firebaseMessagingToken;
}

Future<void> _setupFlutterNotifications() async {
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
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (payload) {
  //   print('onSelectNotification $payload');
  //   if (payload != null) {
  //     Map<String, dynamic> messageData = json.decode(payload);
  //     //
  //     notificationAction(messageData, 0);
  //   }
  // });

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
  ///
  ///
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  BuildContext context = MyApp.navigatorKey.currentContext!;
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? 'Tittle'),
      content: Text(body ?? 'body'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            // await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SecondScreen(payload),
            //   ),
            // );
          },
        )
      ],
    ),
  );
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
    notificationAction(jsonDecode(payload!), 0);
  }
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
}

void showFlutterNotification(RemoteMessage message) async{
  // print('message ${message.data}');
  // print('message ${message.notification!.body}');
 await  _setupFlutterNotifications();

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  // print('notification ${notification.hashCode}');
  // print('notification ${android}');

  // if (notification != null && android != null) {
  //   print('inside ${android}');

  String title = '';
  String body = '';
  int notificationId=0;
  if (message.data != null ){
      // message.data['title'] != null &&
      // message.data['body'] != null) {
    // title = message.data['title'];
    // body = message.data['body'];
    notificationId=int.parse(message.data['jobId'].toString()) +
        title.length;
  }
  // else if (notification != null) {
  //   title = notification.title!;
  //   body = notification.body!;
  // }

  flutterLocalNotificationsPlugin.show(
   notificationId ,
    notification?.title??'tittle',
    notification?.body??'body',
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        // TODO add a proper drawable resource to android, for now using
        //      one that already exists in example app.
        icon: 'launch_background',
      ),
      iOS: const DarwinNotificationDetails()
    ),
    payload: json.encode(message.data),
  );
  // }
}

// Future<dynamic> selectNotification(String payload) async {
//   print('notification  selectNotification');
//   print(payload);
//   if (payload.isNotEmpty) {
//     Map<String, dynamic> messageData = json.decode(payload);
//
//     notificationAction(messageData, 0);
//   }
// }

notificationAction(Map<String, dynamic> messageData, int delay) async {
  await Future.delayed(Duration(seconds: delay));
  int jobId = int.parse(messageData['jobId'].toString());
  Provider.of<JobsDetailsProvider>(MyApp.navigatorKey.currentContext!,
          listen: false)
      .setJobModel(jobId: jobId);
  Navigator.push(
    MyApp.navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (_) => const JobDetails(),
    ),
  );
}
