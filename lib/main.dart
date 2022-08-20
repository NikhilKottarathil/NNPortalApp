import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';
import 'package:nn_portal/presentation/screens/login.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/in_hand_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:nn_portal/providers/leave_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:nn_portal/routers/app_router.dart';
import 'package:nn_portal/text/text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => JobsProvider()),
        ChangeNotifierProvider(create: (_) => JobsDetailsProvider()),
        ChangeNotifierProvider(create: (_) => LogProvider()),
        ChangeNotifierProvider(create: (_) => InHandProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
      ],
      child: MaterialApp(
        navigatorKey: MyApp.navigatorKey,
        title: 'NN Portal',
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,


        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          scaffoldBackgroundColor: Colors.grey.shade100,
          timePickerTheme:Theme.of(context).timePickerTheme.copyWith(

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
