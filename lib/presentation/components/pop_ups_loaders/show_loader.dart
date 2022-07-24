import 'package:flutter/material.dart';
import 'package:nn_portal/main.dart';

showLoader() {
  showDialog(
    context: MyApp.navigatorKey.currentContext!,
    barrierDismissible: false,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
        // child: Image.asset(
        //   'assets/iwn_lloader.gif',
        //   height: 100,
        //   width: 100,
        // ),
      );
    },
  );
}

hideLoader() {
  Navigator.pop(MyApp.navigatorKey.currentContext!);
}
