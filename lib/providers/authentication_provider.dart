
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/user_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/visa_expire_alert.dart';
import 'package:nn_portal/providers/app_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';

import '../utils/firebase_notification.dart';

class AuthenticationProvider extends ChangeNotifier {
  FormStatus formStatus = FormStatus.initialState;
  UserModel? userModel;

  int? visaExpiringDays;
  int warningCheckDays=15;

  Future<bool> attemptAutoLogin() async {
    try {
      var response = await getDataRequest(
          urlAddress: 'Authenticate/CheckToken', isShowLoader: false,isShowSnackBar: false);
      userModel=UserModel.fromJson(response);
      authSuccess();

      return true;
    } catch (e) {
      return false;
    }
  }
   authSuccess()async{
     await Provider.of<AppProvider>(MyApp.navigatorKey.currentContext!,listen: false).init();

     Provider.of<JobsProvider>(MyApp.navigatorKey.currentContext!,listen: false).getInitialJob();
     Provider.of<LogProvider>(MyApp.navigatorKey.currentContext!,listen: false).getLogs();
     Provider.of<TeamProvider>(
         MyApp.navigatorKey.currentContext!,
         listen: false)
         .getInitialData();
     Navigator.of(MyApp.navigatorKey.currentContext!).pushReplacementNamed('/home');

     if(userModel!.visaExpiry!=null){
       DateTime? visaExpireDateTime=DateFormat('dd-MM-yyyy').parse(userModel!.visaExpiry!);
        visaExpiringDays=visaExpireDateTime.difference(DateTime.now()).inDays;
        if(visaExpiringDays!<warningCheckDays){
          showVisaExpireAlert();
        }
     }
  }

  Future<bool> login({required email, required password}) async {
    formStatus = FormStatus.loading;
    notifyListeners();

    try {
      String? firebaseToken=await getFirebaseMessagingToken();
      var response = await postDataRequest(
          urlAddress: 'Authenticate',
          requestBody: {'username': email, 'password': password,
          'firebaseToken':firebaseToken},
          isShowLoader: false);
      userModel=UserModel.fromJson(response);

      print('login $response');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response['token']);
      formStatus = FormStatus.success;
      notifyListeners();
      authSuccess();
      return true;
    } catch (e) {
      formStatus = FormStatus.failed;
      notifyListeners();

      return false;
    }
  }
  Future logOut() async {

    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.clear();
    RestartWidget.restartApp(MyApp.navigatorKey.currentContext!);

  }
  Future<bool> sendNotification(DateTime dateTime) async {
    try {
      await postDataRequest(
        requestBody: {'startdt':DateFormat('yyyy-MM-dd').format(dateTime)},
          urlAddress: 'JobStaffMappings/SendPushNotifications', isShowLoader: false);

      showSnackBar(message: 'Successful');
      return true;
    } catch (e) {
      return false;
    }
  }
}
