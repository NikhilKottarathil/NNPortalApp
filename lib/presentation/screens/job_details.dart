import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
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
        return value.pageStatus == PageStatus.loaded
            ? NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                        [ JobFullDetails(
                          jobModel: value.jobModel!,
                        ),]),
                  ),
                ];
              },
              body:Container(
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.secondaryBase, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  color: AppColors.tertiary.withOpacity(.5),
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.tertiary,
                        border: Border.all(color: AppColors.tertiary),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(3),
                      child: TabBar(
                          indicatorColor: Colors.grey,
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          indicator: BoxDecoration(
                              color: AppColors.primaryBase,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                )
                              ]),
                          onTap: (index) {
                            setState(() {});
                          },
                          controller: _tabController,
                          labelColor: AppColors.textLight,
                          unselectedLabelColor: AppColors.textDark,
                          tabs: const [
                            Tab(text: "Notes"),
                            Tab(text: "Attachments"),
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: [
                            JobNotes(),
                            JobAttachments(),
                          ]),
                    ),
                  ],
                ),
              ) ,
            )
            : const CustomCircularProgressIndicator();
      }),
    );
  }
}
