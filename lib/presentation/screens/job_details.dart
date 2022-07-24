import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/presentation/screens/job_attachments.dart';
import 'package:nn_portal/presentation/screens/job_full_details.dart';
import 'package:nn_portal/presentation/screens/job_notes.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({Key? key}) : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('Job Details'),
      ),
      body: Consumer<JobsDetailsProvider>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: JobFullDetails(jobModel: value.jobModel!,),

            ),
            Card(
              elevation: .5,
              child: TabBar(
                labelColor: AppColors.textDark,
                labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500,color: AppColors.textDark),
                unselectedLabelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.normal,color: AppColors.textDarkSecondary),
                padding: EdgeInsets.only(bottom: 4,top: 12),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: AppColors.textDarFourth,
                indicatorWeight: 1,
                labelPadding: EdgeInsets.only(bottom: 8),
                unselectedLabelColor: AppColors.textDarkSecondary,
                controller: _tabController,
                tabs: const [
                  Text('Notes'),
                  Text('Attachments'),
                ],
              ),
            ),
            Expanded(
              child:  TabBarView(
                controller: _tabController,
                  children: [
                JobNotes(),
                    JobAttachments(),
              ]),
            ),
          ],
        );
      }),
    );
  }


}
