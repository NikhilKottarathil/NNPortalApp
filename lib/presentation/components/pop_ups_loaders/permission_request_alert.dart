import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:permission_handler/permission_handler.dart';


Future showStoragePermissionRequest() async {
  await showDialog(
      context: MyApp.navigatorKey.currentContext!,
      useSafeArea: true,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.all(0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius:const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)),
                color: AppColors.primaryBase,
              ),
              padding:const EdgeInsets.all(20),
              child:const Icon(
                Icons.storage,
                color: Colors.white,
                size: 32,
              ),
            ),
           const Padding(
              padding:  EdgeInsets.all(20.0),
              child: Text(
                'Netnnet needs access to your storage, so give permission access your storage',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding:
                     const  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "CANCEL",
                        style: Theme.of(context).textTheme.button,
                      )),
                ),
               const  SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    openAppSettings();
                        Navigator.of(context).pop();

                  },
                  child: Padding(
                      padding:
                    const  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "CONTINUE",
                        style:  Theme.of(context).textTheme.button,
                      )),
                ),
               const SizedBox(
                  width: 10,
                ),
              ],
            ),
           const SizedBox(
              height: 10,
            ),
          ],
        ),
      ));
  return false;
}
