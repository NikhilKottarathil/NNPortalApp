import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/admin_job_model.dart';
import 'package:nn_portal/models/assigned_team_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:provider/provider.dart';

class AssignedTeamTile extends StatelessWidget {
  final AssignedTeamModel model;
  final bool showTrailingIcon;

  const AssignedTeamTile(
      {Key? key, required this.model, this.showTrailingIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: .5,
      child: ColoredBox(
        color: AppColors.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  
                  Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Team Name',
                                  )),
                              const Text(' : '),
                              Expanded(
                                  flex: 3,
                                  child: Text(model.teamName??'',
                                      style:
                                      Theme.of(context).textTheme.titleMedium)),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Expanded(flex: 1, child: Text('Description')),
                              const Text(' : '),
                              Expanded(flex: 3, child: Text(model.description??'')),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Assigned for',
                                  )),
                              const Text(' : '),
                              Expanded(
                                  flex: 3,
                                  child: Text(model.assignedFor ?? '',
                                      style:
                                      Theme.of(context).textTheme.bodyMedium)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Vehicle',
                                  )),
                              const Text(' : '),
                              Expanded(
                                  flex: 3,
                                  child: Text(model.vehicleName??'',
                                      style:
                                      Theme.of(context).textTheme.bodyMedium)),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 18),
                    icon: Image.asset('assets/delete.png',height: 21,),
                    iconSize: 21,
                    onPressed: () {
                      showCustomAlertDialog(
                          message: 'Are you sure to delete?',
                          negativeButtonText: 'Cancel',
                          positiveButtonText: 'CONFIRM',
                          positiveButtonAction: () {
                            Provider.of<AssignTeamProvider>(
                                MyApp.navigatorKey.currentContext!,
                                listen: false)
                                .delete(model: model);
                            Navigator.pop(context);
                          });
                    },
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
