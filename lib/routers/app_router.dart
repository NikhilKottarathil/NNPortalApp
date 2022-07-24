import 'package:flutter/material.dart';
import 'package:nn_portal/presentation/screens/home.dart';
import 'package:nn_portal/presentation/screens/job_details.dart';
import 'package:nn_portal/presentation/screens/login.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:provider/provider.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    // final GlobalKey<ScaffoldState> key = settings.arguments;
    var arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => Login(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case '/jobDetails':
        return MaterialPageRoute(
          builder: (_) => const JobDetails(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
            ),
            body: const Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
