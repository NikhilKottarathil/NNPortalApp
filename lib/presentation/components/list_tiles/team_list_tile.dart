import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/admin_job_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/team_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/assigned_teams.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/job_team_mapping.dart';
import 'package:nn_portal/presentation/screens/teams/add_staff_to_team.dart';
import 'package:nn_portal/presentation/screens/teams/add_team.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamListTile extends StatelessWidget {
  final TeamModel teamModel;
  final bool showTrailingIcon;
  final int siNo;

  const TeamListTile(
      {Key? key,
      required this.teamModel,
      this.showTrailingIcon = true,
      required this.siNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: .5,
      child: ColoredBox(
        color: AppColors.tertiary,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${siNo + 1}. ${teamModel.teamName}',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 6,
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
                            Provider.of<TeamProvider>(
                                    MyApp.navigatorKey.currentContext!,
                                    listen: false)
                                .delete(teamModel: teamModel);
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
                      addTeam(teamModel: teamModel);
                    },
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.only(right: 18),
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 26,
                    onPressed: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AddStaffToTeam(
                                    teamModel: teamModel,
                                  )));
                    },
                  ),
                  GestureDetector(

                    child: Row(
                      children: [
                        const Icon(Icons.add_circle_outline,size: 26,),
                        const SizedBox(width: 4,),
                        Text('Assign Job',style: Theme.of(context).textTheme.labelMedium,)
                      ],
                    ),
                    onTap: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => JobTeamMapping(
                                    teamModel: teamModel,
                                parentPage: 'team',
                                  )));
                    },
                  ),
                 const SizedBox(width: 18,),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Switch(
                        activeColor:
                        Colors.grey.shade800,
                        trackColor:
                            MaterialStateProperty.all(Colors.grey),
                        inactiveThumbColor: Colors.grey.shade100,
                        value: teamModel.isActive ?? false,
                        onChanged: (value) {
                          Provider.of<TeamProvider>(
                                  MyApp.navigatorKey.currentContext!,
                                  listen: false)
                              .changeStatus(teamModel: teamModel);
                        }),
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
