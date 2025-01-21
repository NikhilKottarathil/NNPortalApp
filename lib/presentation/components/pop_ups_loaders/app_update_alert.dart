import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';

qppUpdateAlert() async {
  int versionCode=0;
  await showModalBottomSheet(
      elevation: 10,
      useRootNavigator: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          )),
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.primaryBase,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              )),
          padding:
          const EdgeInsets.only(top: 30, bottom: 35, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update App !!!",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.textLight),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                 'The app cant use no longer ,please update',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.textLight),
              ),

              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.textLight, backgroundColor: AppColors.secondaryBase),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          ),
        );
      });
}
