// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xpresshealthdev/ui/user/home/completed_shift_screen.dart';
// import '../ui/user/sidenav/notification_screen.dart';
// import '/main.dart';
//
// import '../Constants/sharedPrefKeys.dart';
// import '../resources/api_provider.dart';
// import '../resources/token_provider.dart';
// import '../ui/manager/home/shift_detail_manager.dart';
// import '../ui/user/detail/shift_detail.dart';
// import '../ui/widgets/screen_case.dart';
// import 'location_tracker.dart';
// import 'notification_controller.dart';
//
//
//
// class FCM {
//   final _userNotificationCounter = PublishSubject<int>();
//   Stream<int> get notificationCount => _userNotificationCounter.stream;
//   String fcmToken = "";
//   late Stream<String> _tokenStream;
//
//   Future<void> init() async {
//
//     SharedPreferences shdPre = await SharedPreferences.getInstance();
//     int notificationCount = shdPre.getInt(SharedPrefKey.USER_NOTIFICATION_COUNT) ?? 0;
//     _userNotificationCounter.sink.add(notificationCount);
//     _userNotificationCounter.listen((count) {
//       print("fsfd");
//     });
//     await FirebaseMessaging.instance.setAutoInitEnabled(true);
//
//     getFCMToken();
//
//     await FirebaseMessaging.instance.subscribeToTopic("All_Devices");
//     setUpNotification();
//     FirebaseMessaging.onMessage.listen(foregroundListen);
//     FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpen);
//   }
//
//   getFCMToken() async {
//     FirebaseMessaging.instance.getToken().then(setToken);
//     _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
//     _tokenStream.listen(setToken);
//   }
//
//   void setToken(String? token) async {
//     debugPrint('FCM Token Initial : $token');
//
//     fcmToken = token!;
//     String auth = await TokenProvider().getToken() ?? "";
//     String user_type = await TokenProvider().getUserId() ?? "";
//     if (auth != "") {
//       var respose =
//       await ApiProvider().updateFCMToken(auth, fcmToken, user_type);
//       debugPrint("FCM Token Updated: $respose");
//     }
//   }
//
//   Future<void> onMessageOpen(RemoteMessage message) async =>
//       showNotification(message);
//
//   Future<void> backgroundListen(RemoteMessage message) async =>
//       showNotification(message);
//
//   Future<void> foregroundListen(RemoteMessage message) async =>
//       showNotification(message);
//
//   showNotification(RemoteMessage message) async {
//     String? imageUrl;
//     imageUrl ??= message.notification!.android?.imageUrl;
//     imageUrl ??= message.notification!.apple?.imageUrl;
//     SharedPreferences shdPre = await SharedPreferences.getInstance();
//     int notificationCount = shdPre.getInt(SharedPrefKey.USER_NOTIFICATION_COUNT) ?? 0;
//     shdPre.setInt(SharedPrefKey.USER_NOTIFICATION_COUNT, notificationCount + 1);
//     _userNotificationCounter.sink.add(notificationCount + 1);
//     debugPrint("Notification Count: ${notificationCount + 1}");
//     Map<String, String> payload = <String, String>{};
//     if (message.data["payload"] != null) {
//       if("SET" == jsonDecode(message.data["payload"])["type"].toString()){
//         // LocationTracker().init();
//       }
//       debugPrint(
//           "sdfcddrgdg ${jsonDecode(message.data["payload"]).toString()}");
//       payload["type"] = jsonDecode(message.data["payload"])["type"];
//       payload["id"] = jsonDecode(message.data["payload"])["id"];
//       payload["action"] = jsonDecode(message.data["payload"])["action"] ?? "Open";
//       if ("SHIFT_DETAILS" == jsonDecode(message.data["payload"])["type"].toString()) {
//         AwesomeNotifications().createNotification(
//             content: NotificationContent(
//               id: Random().nextInt(2147483647),
//               notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//                   ? NotificationLayout.Inbox
//                   : NotificationLayout.BigPicture,
//               channelKey: 'basic_channel',
//               title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//                   message.notification?.title,
//               body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//                   message.notification?.body,
//               payload: payload,
//               category: message.data["category"],
//               bigPicture: imageUrl,
//               wakeUpScreen: true,
//               fullScreenIntent: true,
//               criticalAlert: true,
//               showWhen: true,
//               displayOnForeground: true,
//               displayOnBackground: true,
//               locked: false,
//             ),
//             actionButtons: [
//               NotificationActionButton(
//                 key: "Open",
//                 label: payload["action"] ?? "Open",
//               ),
//             ]);
//       }
//       else {
//         AwesomeNotifications().createNotification(
//             content: NotificationContent(
//               id: Random().nextInt(2147483647),
//               notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//                   ? NotificationLayout.Inbox
//                   : NotificationLayout.BigPicture,
//               channelKey: 'basic_channel',
//               title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//                   message.notification?.title,
//               body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//                   message.notification?.body,
//               payload: payload,
//               category: message.data["category"],
//               bigPicture: imageUrl,
//               wakeUpScreen: true,
//               fullScreenIntent: true,
//               criticalAlert: true,
//               showWhen: true,
//               displayOnForeground: true,
//               displayOnBackground: true,
//               locked: false,
//             ),
//             actionButtons: [
//               NotificationActionButton(
//                 key: "Open",
//                 label: payload["action"] ?? "Open",
//               ),
//             ]);
//       }
//     }else{
//       AwesomeNotifications().createNotification(
//           content: NotificationContent(
//             id: Random().nextInt(2147483647),
//             notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//                 ? NotificationLayout.Inbox
//                 : NotificationLayout.BigPicture,
//             channelKey: 'basic_channel',
//             title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//                 message.notification?.title,
//             body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//                 message.notification?.body,
//             payload: payload,
//             category: message.data["category"],
//             bigPicture: imageUrl,
//             wakeUpScreen: true,
//             fullScreenIntent: true,
//             criticalAlert: true,
//             showWhen: true,
//             displayOnForeground: true,
//             displayOnBackground: true,
//             locked: false,
//           ),
//           actionButtons: [
//             NotificationActionButton(
//               key: "Open",
//               label: payload["action"] ?? "Open",
//             ),
//           ]);
//     }
//   }
//
//   void setUpNotification() {
//     AwesomeNotifications().initialize(
//         null,
//         [
//           NotificationChannel(
//               channelGroupKey: 'basic_channel_group',
//               channelKey: 'basic_channel',
//               /* same name */
//               channelName: 'Basic notifications',
//               channelDescription: 'Notification channel for basic tests',
//               defaultColor: const Color(0xFF9D50DD),
//               groupSort: GroupSort.Desc,
//               groupAlertBehavior: GroupAlertBehavior.Children,
//               importance: NotificationImportance.Max,
//               channelShowBadge: true,
//               criticalAlerts: false,
//               ledColor: Colors.white)
//         ],
//         // Channel groups are only visual and are not required
//         channelGroups: [
//           NotificationChannelGroup(
//               channelGroupKey: 'basic_channel_group',
//               channelGroupName: 'Basic group')
//         ],
//         debug: false);
//
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//
//     ////Notification Listener
//     // AwesomeNotifications().actionStream.listen((ReceivedAction receivedAction) {
//     //   debugPrint("Action: \n${receivedAction.toMap().toString()}\n");
//     //   debugPrint("Action2: \n${receivedAction.payload?["id"].toString()}\n");
//     //   print("qqqqqqqq on Action");
//     //   onclick(receivedAction.payload?["type"].toString() ?? "",
//     //       receivedAction.payload?["id"].toString() ?? "");
//     //   return;
//     // });
//   }
//
// }
//
// @pragma('vm:entry-point')
// Future<void> backgroundListen(RemoteMessage message) async {
//
//   return showNotification(message);
// }
// showNotification(RemoteMessage message) async {
//   String? imageUrl;
//   imageUrl ??= message.notification!.android?.imageUrl;
//   imageUrl ??= message.notification!.apple?.imageUrl;
//   SharedPreferences shdPre = await SharedPreferences.getInstance();
//   int notificationCount = shdPre.getInt(SharedPrefKey.USER_NOTIFICATION_COUNT) ?? 0;
//   shdPre.setInt(SharedPrefKey.USER_NOTIFICATION_COUNT, notificationCount + 1);
//   debugPrint("Notification Count: ${notificationCount + 1}");
//   Map<String, String> payload = <String, String>{};
//   if (message.data["payload"] != null) {
//     debugPrint(
//         "sdfcddrgdg ${jsonDecode(message.data["payload"]).toString()}");
//     payload["type"] = jsonDecode(message.data["payload"])["type"];
//     payload["id"] = jsonDecode(message.data["payload"])["id"];
//     payload["action"] = jsonDecode(message.data["payload"])["action"] ?? "Open";
//     if("SET" == jsonDecode(message.data["payload"])["type"].toString()){
//       // LocationTracker().init();
//     }
//
//     if ("SHIFT_DETAILS" ==
//         jsonDecode(message.data["payload"])["type"].toString()) {
//       AwesomeNotifications().createNotification(
//           content: NotificationContent(
//             id: Random().nextInt(2147483647),
//             notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//                 ? NotificationLayout.Inbox
//                 : NotificationLayout.BigPicture,
//             channelKey: 'basic_channel',
//             title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//                 message.notification?.title,
//             body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//                 message.notification?.body,
//             payload: payload,
//             category: message.data["category"],
//             bigPicture: imageUrl,
//             wakeUpScreen: true,
//             fullScreenIntent: true,
//             criticalAlert: true,
//             showWhen: true,
//             displayOnForeground: true,
//             displayOnBackground: true,
//             locked: false,
//           ),
//           actionButtons: [
//             NotificationActionButton(
//               key: "Open",
//               label: payload["action"] ?? "Open",
//             ),
//           ]);
//     }
//     else {
//       AwesomeNotifications().createNotification(
//           content: NotificationContent(
//             id: Random().nextInt(2147483647),
//             notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//                 ? NotificationLayout.Inbox
//                 : NotificationLayout.BigPicture,
//             channelKey: 'basic_channel',
//             title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//                 message.notification?.title,
//             body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//                 message.notification?.body,
//             payload: payload,
//             category: message.data["category"],
//             bigPicture: imageUrl,
//             wakeUpScreen: true,
//             fullScreenIntent: true,
//             criticalAlert: true,
//             showWhen: true,
//             displayOnForeground: true,
//             displayOnBackground: true,
//             locked: false,
//           ),
//           actionButtons: [
//             NotificationActionButton(
//               key: "Open",
//               label: payload["action"] ?? "Open",
//             ),
//           ]);
//     }
//   }else{
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: Random().nextInt(2147483647),
//           notificationLayout: AwesomeStringUtils.isNullOrEmpty(imageUrl)
//               ? NotificationLayout.Inbox
//               : NotificationLayout.BigPicture,
//           channelKey: 'basic_channel',
//           title: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_TITLE] ??
//               message.notification?.title,
//           body: message.data[NOTIFICATION_CONTENT]?[NOTIFICATION_BODY] ??
//               message.notification?.body,
//           payload: payload,
//           category: message.data["category"],
//           bigPicture: imageUrl,
//           wakeUpScreen: true,
//           fullScreenIntent: true,
//           criticalAlert: true,
//           showWhen: true,
//           displayOnForeground: true,
//           displayOnBackground: true,
//           locked: false,
//         ),
//         actionButtons: [
//           NotificationActionButton(
//             key: "Open",
//             label: payload["action"] ?? "Open",
//           ),
//         ]);
//   }
//
//
//
// }