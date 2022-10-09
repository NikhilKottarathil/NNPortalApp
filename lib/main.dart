import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/firebase_options.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';
import 'package:nn_portal/presentation/screens/login.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/in_hand_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:nn_portal/providers/leave_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:nn_portal/routers/app_router.dart';
import 'package:nn_portal/utils/firebase_notification.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();

  runApp(RestartWidget(child: const MyApp()));

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light // status bar color
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
        ChangeNotifierProvider(create: (_) => AdminJobsProvider()),
        ChangeNotifierProvider(create: (_) => AssignTeamProvider()),
        ChangeNotifierProvider(create: (_) => JobsDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LogProvider()),
        ChangeNotifierProvider(create: (_) => InHandProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
        ChangeNotifierProvider(create: (_) => TeamProvider()),
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        title: 'NN Portal',
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          scaffoldBackgroundColor: Colors.grey.shade100,
          timePickerTheme: Theme.of(context).timePickerTheme.copyWith(),
          checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
            // fillColor: MaterialStateProperty.all(Colors.grey.shade600),
            fillColor: MaterialStateProperty.all(Colors.grey.shade800),
             ),

          appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0.5,
              backgroundColor: AppColors.primaryBase,
              // titleTextStyle: Theme.of(context).textTheme.titleMedium,
              foregroundColor: Colors.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light)),
        ).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.primaryBase,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.textDark)),
        home: Login(),
      ),
    );
  }
}
