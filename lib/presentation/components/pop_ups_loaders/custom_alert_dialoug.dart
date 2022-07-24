import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';

showCustomAlertDialog(
    {
    final String? heading,
    required String? message,
    final String? negativeButtonText,
    required String positiveButtonText,
    required Function positiveButtonAction,
    final Function? negativeButtonAction}) async {
  await showDialog(
      context: MyApp.navigatorKey.currentContext!,
      useSafeArea: true,
      builder: (alertContext) => AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            // backgroundColor: Colors.black,
            contentPadding:const  EdgeInsets.all(0),
            content: Container(
              width: double.maxFinite,
              padding:
                 const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 30),
              decoration: BoxDecoration(
                // color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // heading != null ? Text(heading) : Container(),
                  SizedBox(
                    height: MediaQuery.of(MyApp.navigatorKey.currentContext!).size.height * .02,
                  ),
                  if (message != null)
                    Text(
                      message,
                      style:const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  if (message != null)
                    SizedBox(
                      height: MediaQuery.of(MyApp.navigatorKey.currentContext!).size.height * .02,
                    ),
                  Row(
                    children: [
                      if (negativeButtonText != null)
                        InkWell(
                          onTap: () {
                            negativeButtonAction != null
                                ? negativeButtonAction()
                                : Navigator.of(alertContext).pop();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: AppColors.textDark)),
                            padding: EdgeInsets.only(
                                top: 10, right: 20, left: 20, bottom: 10),
                            child: Text(
                              negativeButtonText,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFFFF0404)),
                            ),
                          ),
                        ),
                      if (negativeButtonText != null)
                        SizedBox(
                          width: 15,
                        ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            positiveButtonAction();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBase,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              child: Text(
                                positiveButtonText == null
                                    ? 'Yes'
                                    : positiveButtonText,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
  return false;
}
