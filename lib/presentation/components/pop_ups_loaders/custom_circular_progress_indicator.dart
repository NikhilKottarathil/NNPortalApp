import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Center(child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: CircularProgressIndicator(color: AppColors.primaryBase,),
    ),
    );
  }
}