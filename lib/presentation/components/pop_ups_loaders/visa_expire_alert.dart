import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

showVisaExpireAlert() async {
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
                Provider.of<AuthenticationProvider>(context, listen: false)
                            .visaExpiringDays! >
                        0
                    ? 'Visa Expiring Soon !!!'
                    : "Visa Expired !!!",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.textLight),
              ),
              const SizedBox(
                height: 12,
              ),
              if (Provider.of<AuthenticationProvider>(context, listen: false)
                  .visaExpiringDays! >=
                  0)
              Text(
                Provider.of<AuthenticationProvider>(context, listen: false)
                            .visaExpiringDays! >
                        0
                    ? 'Remaining Days'
                    : 'Expired Days',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.textLight),
              ),

              const SizedBox(
                height: 4,
              ),
              if (Provider.of<AuthenticationProvider>(context, listen: false)
                      .visaExpiringDays! >=
                  0)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryBase,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .visaExpiringDays
                        .toString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight),
                  ),
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
