import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/presentation/components/restarted_widget.dart';
import 'package:nn_portal/presentation/screens/login.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryBase,
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(14),
              child: Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: MediaQuery.of(context).size.width * .3,
                      color: Colors.white,
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
            const SizedBox(
              height: 20,
            ),
            Spacer(),
            button(
                text: 'LogOut',
                onPressed: () async {
                  // Provider.of<AuthenticationProvider>(context,listen: false).logOut();
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Login(),
                      ),
                      (route) => false);

                  RestartWidget.restartApp(context);
                })
          ],
        ),
      ),
    );
  }

  Widget button({required String text, required Function onPressed}) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(elevation: MaterialStateProperty.all(0.5)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.textLight),
          ),
        ),
      ),
    );
  }
}
