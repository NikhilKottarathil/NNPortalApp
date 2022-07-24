import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

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
        child: ListView(
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
            // button(text: 'Vehicle history')
          ],
        ),
      ),
    );
  }

  Widget button({required String text}) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(elevation: MaterialStateProperty.all(0.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
