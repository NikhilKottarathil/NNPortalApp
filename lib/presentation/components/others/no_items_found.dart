import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class NoItemsFound extends StatelessWidget {
  const NoItemsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Data to Display',style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.textDarkSecondary),),
    );
  }
}
