import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/presentation/components/custom_webview.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';
import 'package:nn_portal/presentation/components/text_fields/date_picker_text_field.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/admin_job_list.dart';
import 'package:nn_portal/presentation/screens/in_hand.dart';
import 'package:nn_portal/presentation/screens/leaves.dart';
import 'package:nn_portal/presentation/screens/login.dart';
import 'package:nn_portal/presentation/screens/teams/team_list.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/in_hand_provider.dart';
import 'package:nn_portal/providers/leave_provider.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:nn_portal/utils/date_time_conversions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isAdmin = false;


  String version = '1.0.7 ';

  @override
  Widget build(BuildContext context) {

    if (Provider.of<AuthenticationProvider>(context, listen: false)
                .userModel!
                .roleId !=
            null &&
        Provider.of<AuthenticationProvider>(context, listen: false)
                .userModel!
                .roleId ==
            1) {
      isAdmin = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.secondaryBase,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              padding: const EdgeInsets.all(14),
              child: Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: MediaQuery.of(context).size.width * .2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      value.userModel!.staffName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                );
              }),
            ),
            if(!isAdmin)
              const SizedBox(
              height: 20,
            ),
            if(!isAdmin)
            button(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/vehicle_icon.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "In-hand  Vehicles",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark),
                    ),
                  ],
                ),
                onPressed: () {
                  Provider.of<InHandProvider>(context, listen: false)
                      .setLogType(LogType.vehicleLog);
                  Provider.of<InHandProvider>(context, listen: false).getData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const InHand(parentPage: 'In Hand Vehicles'),
                    ),
                  );
                }),
            if(!isAdmin)
              const SizedBox(
              height: 20,
            ),
            if(!isAdmin)
              button(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/tool_icon.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "In-hand  Tools",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark),
                    ),
                  ],
                ),
                onPressed: () {
                  Provider.of<InHandProvider>(context, listen: false)
                      .setLogType(LogType.toolLog);
                  Provider.of<InHandProvider>(context, listen: false).getData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const InHand(parentPage: 'In Hand Tools'),
                    ),
                  );
                }),
            if(!isAdmin)
              const SizedBox(
              height: 20,
            ),
            if(!isAdmin)
              button(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/leave.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Apply Leave",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark),
                    ),
                  ],
                ),
                onPressed: () {
                  Provider.of<LeaveProvider>(context, listen: false)
                      .getInitialData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Leaves(),
                    ),
                  ).then((value) {
                    Provider.of<LeaveProvider>(context, listen: false)
                        .clearLeaveForm();
                  });
                }),
            if(isAdmin)
              const SizedBox(
              height: 20,
            ),
            if (isAdmin)
              button(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/site_icon.png',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jobs",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Provider.of<AdminJobsProvider>(
                            MyApp.navigatorKey.currentContext!,
                            listen: false)
                        .getInitialJob();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AdminJobList(),
                      ),
                    );
                  }),
            if (isAdmin)
              const SizedBox(
              height: 20,
            ),
            // if (isAdmin)
            //   button(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Image.asset(
            //             'assets/work_icon.png',
            //             height: 24,
            //             width: 24,
            //           ),
            //           const SizedBox(
            //             width: 8,
            //           ),
            //           Text(
            //             "Teams",
            //             style: Theme.of(context).textTheme.labelLarge!.copyWith(
            //                 fontWeight: FontWeight.bold,
            //                 color: AppColors.textDark),
            //           ),
            //         ],
            //       ),
            //       onPressed: () {
            //         Provider.of<TeamProvider>(
            //                 MyApp.navigatorKey.currentContext!,
            //                 listen: false)
            //             .getInitialData();
            //
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (_) => TeamList(),
            //           ),
            //         );
            //       }),
            // if (isAdmin)
            //   const SizedBox(
            //     height: 20,
            //   ),
            if (isAdmin)
            notificationWidget(),
            const Spacer(),
            if (Provider.of<AuthenticationProvider>(context, listen: false)
                    .visaExpiringDays !=
                null)
              Text(
                (Provider.of<AuthenticationProvider>(context, listen: false)
                                .visaExpiringDays! >
                            0
                        ? 'Visa Expire date : '
                        : "Visa Expired date : ") +
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .userModel!
                        .visaExpiry!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            const SizedBox(
              height: 20,
            ),
            button(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logout,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Log Out",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLight),
                  ),
                ],
              ),
              isSecondaryColor: true,
              onPressed: () async {
                showCustomAlertDialog(
                  message: 'Are you sure to Logout',
                  positiveButtonText: 'CONFIRM',
                  positiveButtonAction: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();

                    Navigator.pushAndRemoveUntil(
                        MyApp.navigatorKey.currentContext!,
                        MaterialPageRoute(
                          builder: (_) => Login(),
                        ),
                        (route) => false);

                    RestartWidget.restartApp(
                        MyApp.navigatorKey.currentContext!);
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Version $version',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationWidget() {
    DateTime dateTime = DateTime.now();
    return Container(
        width: MediaQuery.of(MyApp.navigatorKey.currentContext!).size.width,
        decoration: BoxDecoration(
            // color:AppColors.tertiary,
            borderRadius: BorderRadius.circular(8)),
        // padding: EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: Theme.of(MyApp.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: DatePickerTextField(
                    dateTime: dateTime,
                    startDate: DateTime.now().subtract(const Duration(days: 365)),
                    callback: (date) {
                      dateTime = date;
                    },
                    validator: (value) {
                      return value!.isEmpty ? 'Select from date' : null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24)),
                    onPressed: () {
                      Provider.of<AuthenticationProvider>(MyApp.navigatorKey.currentContext!,listen:false ).sendNotification(dateTime);
                    },
                    child: const Text('SEND'))
              ],
            ),
          ],
        ));
  }

  Widget button(
      {required Widget child,
      required Function onPressed,
      bool isSecondaryColor = false}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(MyApp.navigatorKey.currentContext!).size.width,
        decoration: BoxDecoration(
            color:
                isSecondaryColor ? AppColors.secondaryBase : AppColors.tertiary,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(17),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version=packageInfo.version;
    print('version $version');
    setState(() {

    });
  }
}
