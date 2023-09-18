import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_strings.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/utils/http_api_calls.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future fileUploadWithDio(
    {required String urlAddress,
    Map<String, String>? requestBody,
    required List<File> files,
    required List<String> fileAddresses,
    CancelToken? cancelToken,
      bool isTestApi=false,
    Function? onUploadProgress,String method='post'}) async {
  if (await checkInternetConnectivity()) {
    try {
      var dio = Dio();

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      if(sharedPreferences.getString('token')!=null){
        dio.options.headers["authorization"] = 'Bearer ${sharedPreferences.getString('token')}';
      }


      var formData = FormData.fromMap(requestBody!);
      if (files.isNotEmpty) {
        int i = 0;
        for (File file in files) {
          String fileName = file.path.split('/').last;

          debugPrint('${fileAddresses[i]} ${file.path} $fileName');
          MultipartFile multipartFile =
              await MultipartFile.fromFile(file.path, filename: fileName);
          formData.files.add(MapEntry(fileAddresses[i], multipartFile));
          i++;
        }
      }
      String endPoint=(isTestApi?AppStrings.textApi:AppStrings.apiAddress )+ urlAddress;

      print(endPoint);
      print(formData.fields);
      var response;
      try {
        if(method=='post') {
          response = await dio.post(endPoint,
              cancelToken: cancelToken,
              data: formData, onSendProgress: (send, total) {
                onUploadProgress!(send, total);
              });
        }else{
          response = await dio.put(AppStrings.apiAddress + urlAddress,
              cancelToken: cancelToken,
              data: formData, onSendProgress: (send, total) {
                onUploadProgress!(send, total);
              });
        }
        print("asu");
      } catch (e) {
        print(e);
        if (e.toString().contains('DioErrorType.cancel')) {
          return null;
        } else {
          throw Exception(AppStrings.somethingWentWrong);
        }
      }

      var responseBody = response.data;
      print(responseBody);
      // var responseBody = jsonDecode(response.);
      // print(responseBody);
      if (response.statusCode == 200) {
        debugPrint('============= dio end ${AppStrings.apiAddress+urlAddress} post api =============== \n$responseBody');
        if (responseBody['success'] != null) {
          if (responseBody['success']) {
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
      }
    } catch (e) {
      debugPrint(
          '=============dio fail $urlAddress postFile api =============== \n error $e');
      String message = e.toString().substring(10);

      showSnackBar(message: message);
      rethrow;
    }
  }
}
