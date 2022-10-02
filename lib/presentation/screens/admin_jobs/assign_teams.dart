import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/presentation/components/list_tiles/admin_job_list_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_search.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/presentation/screens/job_details.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

class JobTeams extends StatefulWidget {
  const JobTeams({Key? key}) : super(key: key);

  @override
  State<JobTeams> createState() => _JobTeamsState();
}

class _JobTeamsState extends State<JobTeams> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Teams'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      // drawer: HomeDrawer(),
      body: Consumer<AdminJobsProvider>(builder: (context, value, child) {
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
                    return GestureDetector(
                        onTap: () {
                          Provider.of<JobsDetailsProvider>(context,
                              listen: false)
                              .setJobModel(
                              jobModel: value.models[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const JobDetails()));
                        },
                        child: JobListTile(
                            jobModel: value.models[index]));
                  },
                  separatorBuilder:
                      (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                )
                    : const NoItemsFound(),
              ),
              if (value.pageStatus == PageStatus.loadMore)
                const Center(
                  child:  SizedBox(
                      height: 50,width: 50, child:  CustomCircularProgressIndicator()),
                ),
            ],
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBase,
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (_)=>AddJob()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

