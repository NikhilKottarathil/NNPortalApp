import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/utils/dio_api_calls.dart';


Future showUploadFileAlert({
  bool showUploadBytes=true,
 required String urlAddress,
required  Map<String, String> requestBody,
 required List<File> files,
 required List<String> fileAddresses,
  String method='post',
  bool isTestApi=false,
}) async {
  double totalByteLength = 0.0, uploadedByteLength = 0.0;
  double progress = 0.0;
  //change if need an alert
  bool isInitial = true;
  // bool isProcessCompleted = false;
  CancelToken cancelToken = CancelToken();

  var responseBody;
  await showModalBottomSheet(
      elevation: 10,
      useRootNavigator: true,
      isDismissible: false,
      shape:const  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext bottomSheetContext) {
        return StatefulBuilder(builder: (context, setState) {
          if (isInitial) {
            isInitial = false;
            try {
              fileUploadWithDio(
                  urlAddress: urlAddress,
                  requestBody: requestBody,
                  files: files,
                  fileAddresses: fileAddresses,
                  cancelToken: cancelToken,
                  method: method,
                  isTestApi: isTestApi,
                  onUploadProgress: (uploaded, total) {
                    try {
                      setState(() {
                        totalByteLength = total / 1024 / 1024;
                        uploadedByteLength = uploaded / 1024 / 1024;
                        progress = uploaded / total;
                      });

                    } catch (e) {

                      debugPrint(e.toString());
                    }
                  }).then((value){
                if (uploadedByteLength >= totalByteLength) {
                  responseBody = value;
                  Navigator.of(bottomSheetContext).pop();
                }
              });
            } catch (e) {
              Navigator.of(bottomSheetContext).pop();
            }
          }
          return Container(
            decoration:const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                )),
            padding:const  EdgeInsets.only(top: 30, bottom: 35, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Uploading Please wait',
                      style: Theme.of(MyApp.navigatorKey.currentContext!)
                          .textTheme
                          .titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              const   SizedBox(
                  height: 30,
                ),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade500,
                  color: Colors.black,
                ),
                if (showUploadBytes)
                 const SizedBox(
                    height: 10,
                  ),
                if (showUploadBytes)
                  Text(
                    '${uploadedByteLength.toStringAsFixed(1)}MB | ${totalByteLength.toStringAsFixed(1)}MB ',
                    style: Theme.of(MyApp.navigatorKey.currentContext!)
                        .textTheme
                        .bodyMedium,
                    textAlign: TextAlign.end,
                  ),
               const  SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        cancelToken.cancel();
                        Navigator.of(bottomSheetContext).pop();
                      },
                      child: Container(
                        margin:const  EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: AppColors.textDark)),
                        padding:const  EdgeInsets.only(
                            top: 10, right: 20, left: 20, bottom: 10),
                        child:  Text(
                          'CANCEL',
                          style:Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      });

  return responseBody;
}
