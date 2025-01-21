import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/list_tiles/admin_job_list_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/assigned_team_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_search.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/job_team_mapping.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:provider/provider.dart';

class AssignedTeams extends StatefulWidget {
  final JobModel jobModel;
 final bool isFromJob;
  const AssignedTeams({Key? key,required this.jobModel,this.isFromJob=true}) : super(key: key);

  @override
  State<AssignedTeams> createState() => _AssignedTeamsState();
}

class _AssignedTeamsState extends State<AssignedTeams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Teams'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      // drawer: HomeDrawer(),
      body: Consumer<AssignTeamProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: value.pageStatus == PageStatus.loading
                    ? const CustomCircularProgressIndicator()
                    : value.models.isNotEmpty
                        ? ListView.separated(
                            itemCount: value.models.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return AssignedTeamTile(
                                  model: value.models[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Teams to display',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: AppColors.textDarkSecondary),
                                ),
                                const SizedBox(height: 8,),
                                Text(
                                  'Press "+" button to add ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: AppColors.textDarkSecondary),
                                ),
                              ],
                            ),
                          ),
              ),
              if (value.pageStatus == PageStatus.loadMore)
                const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomCircularProgressIndicator()),
                ),
            ],
          ),
        );
      }),

      floatingActionButton: widget.isFromJob?FloatingActionButton(
        backgroundColor: AppColors.primaryBase,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => JobTeamMapping(
                    jobModel: widget.jobModel,
                    parentPage: 'job',
                  ))).then((value) {
            Provider.of<AssignTeamProvider>(
                MyApp.navigatorKey.currentContext!,
                listen: false)
                .getData(jobId: widget.jobModel.id!.toString());
          });        },
        child:const  Icon(Icons.add),
      ):null,
    );
  }
}
