import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nn_portal/constants/app_constanrs.dart';
import 'package:nn_portal/constants/app_strings.dart';

import 'package:nn_portal/presentation/components/pop_ups_loaders/show_loader.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      throw Exception('No Internet');
    }
  } on SocketException catch (_) {
    showSnackBar(message: 'No Internet');
    return false;
  }
}

Future postDataRequest(
    {required String urlAddress,
    required Map<String, dynamic> requestBody,
      String method='post',
    bool isShowLoader = true}) async {
  debugPrint('============= start $urlAddress post api ===============');

  if (await checkInternetConnectivity()) {
    // try {
      if (isShowLoader) {
        showLoader();
      }

      final uri = Uri.parse(apiAddress + urlAddress);
      Map<String, String> headers = {"Content-Type": "application/json"};

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      if(sharedPreferences.getString('token')!=null){
        headers.addAll({'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});
      }
      print('requestBody $requestBody');

      var response ;
      if(method=='post') {
        response =
        await http.post(uri, body: json.encode(requestBody),
            headers: headers,
            encoding: Encoding.getByName("utf-8"));
      }else if(method=='put'){
        response =
        await http.put(uri, body: json.encode(requestBody),
            headers: headers,
            encoding: Encoding.getByName("utf-8"));
      }
      var responseBody = jsonDecode(response.body);

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 404) {
        debugPrint(
            '============= end ${apiAddress+urlAddress} post api =============== \n $responseBody');

        if (responseBody['success'] != null) {
          if (responseBody['success']) {
            if (isShowLoader) {
              hideLoader();
            }
            return responseBody['result'];
          } else {
            if (responseBody['message'] != null) {
              throw Exception(responseBody['message']);
            } else {
              throw Exception(AppStrings.somethingWentWrong);
            }
          }
        } else {
          if (responseBody['message'] != null) {
            throw Exception(responseBody['message']);
          } else {
            throw Exception(AppStrings.somethingWentWrong);
          }
        }
      } else {
        throw Exception(AppStrings.somethingWentWrong);
      }
    // } catch (e) {
    //   debugPrint(
    //       '============= fail ${apiAddress+urlAddress} post api =============== \n error $e');
    //
    //   print(e);
    //   String message = e.toString().substring(10);
    //   if (isShowLoader) {
    //     hideLoader();
    //   }
    //   showSnackBar(message: message);
    //   rethrow;
    // }
  }
}



Future getDataRequest(
    {required String urlAddress, bool isShowLoader = true,bool isShowSnackBar =true}) async {
  debugPrint('============= start $urlAddress get api ===============');

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }



      final uri = Uri.parse(AppStrings.apiAddress+urlAddress);
      Map<String, String> headers = {"Content-Type": "application/json"};
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      if(sharedPreferences.getString('token')!=null){
        headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${sharedPreferences.getString('token')}'});
      }
      print('header $headers');

      final response = await http.get(uri, headers: headers);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint(
            '============= end $urlAddress get api =============== \n $responseBody');
        if (responseBody['success'] != null) {
          if (responseBody['success']) {
            if (isShowLoader) {
              hideLoader();
            }
            return responseBody['result'];
          } else {
            if (responseBody['message'] != null) {
              throw Exception(responseBody['message']);
            } else {
              throw Exception(AppStrings.somethingWentWrong);
            }
          }
        } else {
          if (responseBody['message'] != null) {
            throw Exception(responseBody['message']);
          } else {
            throw Exception(AppStrings.somethingWentWrong);
          }
        }
      } else {
        throw Exception(AppStrings.somethingWentWrong);
      }
    } catch (e) {
      debugPrint(
          '============= fail $urlAddress get api =============== \n error $e');
      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      if(isShowSnackBar) {
        showSnackBar(message: message);
      }
      rethrow;
    }
  }
}


Future deleteDataRequest(
    {required String urlAddress, bool isShowLoader = true}) async {
  debugPrint('============= start $urlAddress get api ===============');

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }



      final uri = Uri.parse(AppStrings.apiAddress+urlAddress);
      Map<String, String> headers = {"Content-Type": "application/json"};
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      if(sharedPreferences.getString('token')!=null){
        headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${sharedPreferences.getString('token')}'});
      }
      print('header $headers');

      final response = await http.delete(uri, headers: headers);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint(
            '============= end $urlAddress get api =============== \n $responseBody');
        if (responseBody['success'] != null) {
          if (responseBody['success']) {
            if (isShowLoader) {
              hideLoader();
            }
            return responseBody['result'];
          } else {
            if (responseBody['message'] != null) {
              throw Exception(responseBody['message']);
            } else {
              throw Exception(AppStrings.somethingWentWrong);
            }
          }
        } else {
          if (responseBody['message'] != null) {
            throw Exception(responseBody['message']);
          } else {
            throw Exception(AppStrings.somethingWentWrong);
          }
        }
      } else {
        throw Exception(AppStrings.somethingWentWrong);
      }
    } catch (e) {
      debugPrint(
          '============= fail $urlAddress get api =============== \n error $e');
      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      showSnackBar(message: message);
      rethrow;
    }
  }
}
