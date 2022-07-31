
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/user_model.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';

class AuthenticationProvider extends ChangeNotifier {
  FormStatus formStatus = FormStatus.initialState;
  UserModel? userModel;

  Future<bool> attemptAutoLogin() async {
    try {
      var response = await getDataRequest(
          urlAddress: 'Authenticate/CheckToken', isShowLoader: false,isShowSnackBar: false);
      userModel=UserModel.fromJson(response);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login({required email, required password}) async {
    formStatus = FormStatus.loading;
    notifyListeners();

    try {
      var response = await postDataRequest(
          urlAddress: 'Authenticate',
          requestBody: {'username': email, 'password': password},
          isShowLoader: false);
      userModel=UserModel.fromJson(response);

      print('login $response');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response['token']);
      formStatus = FormStatus.success;
      notifyListeners();
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
}
