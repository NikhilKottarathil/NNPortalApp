import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width*.8,
      // backgroundColor: AppColors.primaryBase,

      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: AppColors.primaryBase,
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(14),
              child: Consumer<AuthenticationProvider>(
                  builder: (context, value, child) {
                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: MediaQuery.of(context).size.width * .3,
                      // color: Colors.white,
                    ),
                    Text(
                      value.userModel!.staffName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          // .copyWith(color: Colors.white),
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
}
