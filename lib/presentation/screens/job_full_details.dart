import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/change_job_vehicle.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

class JobFullDetails extends StatelessWidget {
  final JobModel jobModel;

  const JobFullDetails({Key? key, required this.jobModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsDetailsProvider>(
      builder: (context, value, child)  {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
              const SizedBox(height: 8),
              FAWidget(field: 'Client', answer: jobModel.clientName!),
              const SizedBox(height: 8),
              FAWidget(field: 'Open On', answer: jobModel.openOn!),
              if (jobModel.jobVehicles != null && jobModel.jobVehicles!.isNotEmpty)
                const SizedBox(height: 8),
              if (jobModel.jobVehicles != null && jobModel.jobVehicles!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Vehicle',
                        style: Theme.of(MyApp.navigatorKey.currentContext!)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '  :  ',
                      style: Theme.of(MyApp.navigatorKey.currentContext!)
                          .textTheme
                          .bodyMedium,
                    ),
                    Expanded(
                        flex: 4,
                        child: Wrap(
                          children: value.jobModel!.jobVehicles!
                              .map(
                                (e) => Row(
                                  children: [
                                    Text(
                                      e.vehicleName!,
                                      style: Theme.of(
                                              MyApp.navigatorKey.currentContext!)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          changeJobVehicle(jobVehicle: e);
                                        },
                                        child: Image.asset(
                                          'assets/edit.png',
                                          height: 18,
                                          width: 18,
                                        )),
                                  ],
                                ),
                              )
                              .toList(),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              if (jobModel.assignedStaff != null) const SizedBox(height: 8),

              if (jobModel.assignedStaff != null)
                FAWidget(field: 'Staffs', answer: jobModel.assignedStaff!),
            ],
          ),
        );
      }
    );
  }

  Widget FAWidget({required String field, required String answer}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$field ',
            style: Theme.of(MyApp.navigatorKey.currentContext!)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '  :  ',
          style:
              Theme.of(MyApp.navigatorKey.currentContext!).textTheme.bodyMedium,
        ),
        Expanded(
          flex: 4,
          child: Text(
            answer,
            style: Theme.of(MyApp.navigatorKey.currentContext!)
                .textTheme
                .bodyMedium,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
