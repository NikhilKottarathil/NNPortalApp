import 'package:flutter/material.dart';
import 'package:nn_portal/main.dart';

void showSnackBar({String? message, Exception? exceptionMessage}) {
  String messageException = exceptionMessage!=null?exceptionMessage.toString().substring(10):'';
  final snackBar = SnackBar(content: Text(message??messageException));
  ScaffoldMessenger.of(MyApp.navigatorKey.currentContext!).showSnackBar(snackBar);
}
