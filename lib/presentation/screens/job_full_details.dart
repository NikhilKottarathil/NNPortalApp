import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';

class JobFullDetails extends StatelessWidget {
  final JobModel jobModel;

  const JobFullDetails({Key? key,required this.jobModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Text(
        //   'Name :',
        //   style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.textDarTertiary),
        // ),
        // SizedBox(height: 8,),
        // Text(
        //   value.jobModel!.locationName!,
        //   style: Theme.of(context).textTheme.titleMedium,
        // ),
        FAWidget(field: 'Location', answer: jobModel.locationName!),
        FAWidget(field: 'Client Name', answer: jobModel.clientName!),

      ],
    );
  }

  Widget FAWidget({required String field,required String answer}){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field :',
          style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.labelMedium!.copyWith(color: AppColors.textDarTertiary),
        ),
        const SizedBox(height: 6,),
        Text(
          answer,
          style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
        ),
       const  SizedBox(height: 15,),
      ],
    );
  }
}

