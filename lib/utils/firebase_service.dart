// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:nn_portal/firebase_options.dart';
// import 'package:nn_portal/main.dart';
// import 'package:nn_portal/presentation/screens/job_details.dart';
// import 'package:nn_portal/providers/job_details_provider.dart';
// import 'package:provider/provider.dart';
//
//
// class FirebaseService {
//   init() async {
//     // if (!kIsWeb && Platform.isIOS) {
//     //   try {
//     //     await Firebase.initializeApp();
//     //   } catch (e) {
//     //     if (kDebugMode) {
//     //       print(e);
//     //     }
//     //   }
//     // } else {
//       try {
//         await Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         );
//       } catch (e) {
//         if (kDebugMode) {
//           print(e);
//         }
//       }
//     // }
//     if (!kIsWeb) {
//
//       if (Platform.isIOS) {
//         await FirebaseMessaging.instance.requestPermission(sound: true, badge: true, alert: true, provisional: false);
//
//         await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//       }
//
//       FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
//         print('nnnotification  getInitialMessage $message');
//         if (message != null) {
//           notificationAction(message.data, 0);
//         }
//       });
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//         notificationAction(message.data, 0);
//       });
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//
//       });
//     }
//   }
//
//   notificationAction(Map<String, dynamic> messageData, int delay) async {
//   await Future.delayed(Duration(seconds: delay));
//   int jobId = int.parse(messageData['jobId'].toString());
//   Provider.of<JobsDetailsProvider>(MyApp.navigatorKey.currentContext!,
//           listen: false)
//       .setJobModel(jobId: jobId);
//   Navigator.push(
//     MyApp.navigatorKey.currentContext!,
//     MaterialPageRoute(
//       builder: (_) => const JobDetails(),
//     ),
//   );
// }
//
//   // Future<void> postFireBaseToken(int? userId) async {
//   //   if (Platform.isIOS) {
//   //     await Firebase.initializeApp();
//   //   } else {
//   //     await Firebase.initializeApp(
//   //         options: DefaultFirebaseOptions.currentPlatform,);
//   //   }
//   // }
// }
