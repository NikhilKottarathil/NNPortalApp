import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';

class JobFullDetails extends StatelessWidget {
  final JobModel jobModel;

  const JobFullDetails({Key? key,required this.jobModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:AppColors.tertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding:const  EdgeInsets.symmetric(horizontal: 12,vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 4),
          FAWidget(field: 'Client', answer: jobModel.clientName!),
          if(jobModel.assignedVehicle!=null)
            const SizedBox(height: 4),
          if(jobModel.assignedVehicle!=null)

            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Vehicle',
                  style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                '  :  ',
                style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
              ),
              Expanded(
                flex: 4,
                child: Text(
                  jobModel.assignedVehicle!,
                  style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
                ),
              ),
              const  SizedBox(height: 15,),
            ],
          ),
          if(jobModel.assignedStaff!=null)
            const SizedBox(height: 4),

          if(jobModel.assignedStaff!=null)

            FAWidget(field: 'Staffs', answer: jobModel.assignedStaff!),

        ],
      ),
    );
  }

  Widget FAWidget({required String field,required String answer}){
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$field ',
            style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
         Text(
          '  :  ',
          style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
        ),
        Expanded(
          flex: 4,
          child: Text(
            answer,
            style: Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
          ),
        ),
       const  SizedBox(height: 15,),
      ],
    );
  }
}

