import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/admin_job_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/assigned_teams.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:provider/provider.dart';

class AdminJobListTile extends StatelessWidget {
  final JobModel jobModel;
  final showTrailingIcon;

  const AdminJobListTile(
      {Key? key, required this.jobModel, this.showTrailingIcon = true})
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
                  // Image.asset(
                  //   jobModel.code!.substring(0, 1).toLowerCase() == 'p'
                  //       ? 'assets/project_job.png'
                  //       : 'assets/site_job.png',
                  //   color: Colors.black,
                  //   height: 62,
                  //   width: 62,
                  // ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Location',
                              )),
                          const Text(' : '),
                          Expanded(
                              flex: 3,
                              child: Text(jobModel.locationName!,
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Client')),
                          const Text(' : '),
                          Expanded(flex: 3, child: Text(jobModel.clientName!)),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Created on',
                              )),
                          const Text(' : '),
                          Expanded(
                              flex: 3,
                              child: Text(jobModel.openOn ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodySmall)),
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
                    icon: Image.asset('assets/delete.png'),
                    iconSize: 21,
                    onPressed: () {
                      showCustomAlertDialog(
                          message: 'Are you sure to delete?',
                          negativeButtonText: 'Cancel',
                          positiveButtonText: 'CONFIRM',
                          positiveButtonAction: () {
                            Provider.of<AdminJobsProvider>(
                                    MyApp.navigatorKey.currentContext!,
                                    listen: false)
                                .delete(jobModel: jobModel);
                            Navigator.pop(context);
                          });
                    },
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 18),
                    icon: Image.asset('assets/edit.png'),
                    iconSize: 21,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddJob(jobModel: jobModel)));
                    },
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 0),
                    icon: Icon(Icons.add_circle_outline),
                    iconSize: 26,
                    onPressed: () {
                      Provider.of<AssignedTeamProvider>(
                              MyApp.navigatorKey.currentContext!,
                              listen: false)
                          .getData(jobId: jobModel.id!.toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AssignedTeam()));
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
