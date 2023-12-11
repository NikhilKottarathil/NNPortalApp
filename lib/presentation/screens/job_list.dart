import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/login_alert.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_search.dart';
import 'package:nn_portal/presentation/drawers/home_drawer.dart';
import 'package:nn_portal/presentation/screens/job_details.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:provider/provider.dart';

class JobList extends StatefulWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  TextEditingController searchTextEditingController = TextEditingController();

  bool isGuest = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<JobsProvider>(context, listen: false). scrollController.
    isGuest = Provider.of<AuthenticationProvider>(context, listen: false)
        .userModel!
        .isGuest!;
    Provider.of<JobsProvider>(context, listen: false)
        .scrollController
        .addListener(() {
      if (Provider.of<JobsProvider>(context, listen: false)
              .scrollController
              .position
              .pixels ==
          Provider.of<JobsProvider>(context, listen: false)
              .scrollController
              .position
              .maxScrollExtent) {
        Provider.of<JobsProvider>(context, listen: false).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find your jobs'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          if (!isGuest)
            const IconButton(onPressed: refresh, icon: Icon(Icons.refresh))
        ],
      ),
      // drawer: HomeDrawer(),
      body: Consumer<JobsProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isGuest) {
                      Provider.of<JobsProvider>(
                              MyApp.navigatorKey.currentContext!,
                              listen: false)
                          .changeJobType(value.jobTypeModels[0]);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.secondaryBase,
                        boxShadow: value.jobTypeModels[0].isSelected
                            ? [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(0, 1),
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]
                            : null,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/all_jobs.png',
                          height: 48,
                        ),
                        Text(
                          'All Jobs',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: AppColors.textLight,
                                  fontSize: 20,
                                  fontWeight: value.jobTypeModels[0].isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
                if (Provider.of<AuthenticationProvider>(context, listen: false)
                            .userModel!
                            .roleId !=
                        null &&
                    Provider.of<AuthenticationProvider>(context, listen: false)
                            .userModel!
                            .roleId ==
                        2)
                  const SizedBox(
                    height: 5,
                  ),
                if (Provider.of<AuthenticationProvider>(context, listen: false)
                            .userModel!
                            .roleId !=
                        null &&
                    Provider.of<AuthenticationProvider>(context, listen: false)
                            .userModel!
                            .roleId ==
                        2)
                  jobTypeTile(
                      jobTypeModel: value.jobTypeModels[1],isGuest:isGuest, isCenter: true),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[2],isGuest:isGuest)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[3],isGuest:isGuest))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[4],isGuest:isGuest)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[5],isGuest:isGuest))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[6],isGuest:isGuest)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child:
                            jobTypeTile(jobTypeModel: value.jobTypeModels[7],isGuest:isGuest))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                jobTypeTile(
                    jobTypeModel: value.jobTypeModels[8], isCenter: true,isGuest:isGuest),
                const SizedBox(
                  height: 10,
                ),
                TextFieldSearch(
                  searchTextEditingController: searchTextEditingController,
                  hintText: 'Search ',
                  searchAction: () {
                    if (!isGuest) {
                      Provider.of<JobsProvider>(context, listen: false)
                          .searchJobs(searchTextEditingController.text);
                    } else {
                      showLoginAlert();
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                Expanded(
                  child: value.pageStatus == PageStatus.loading
                      ? const CustomCircularProgressIndicator()
                      : value.models.isNotEmpty
                          ? ListView.separated(
                              itemCount: value.models.length,
                              // shrinkWrap: true,
                              controller: Provider.of<JobsProvider>(context,
                                      listen: false)
                                  .scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      if (!isGuest) {
                                        Provider.of<JobsDetailsProvider>(
                                                context,
                                                listen: false)
                                            .setJobModel(
                                                jobId: value.models[index].id!);
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const JobDetails()))
                                            .then((value) {
                                          Provider.of<JobsProvider>(context,
                                                  listen: false)
                                              .refresh();
                                        });
                                      }
                                    },
                                    child: JobListTile(
                                        jobModel: value.models[index]));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 7,
                                );
                              },
                            )
                          : const NoItemsFound(),
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
          ),
        );
      }),
    );
  }
}

Future refresh() async {
  await Provider.of<JobsProvider>(MyApp.navigatorKey.currentContext!,
          listen: false)
      .refresh();
}

Widget jobTypeTile(
    {required JobTypeModel jobTypeModel, bool isCenter = false,required bool isGuest}) {
  return GestureDetector(
    onTap: () {
      if(!isGuest) {
        Provider.of<JobsProvider>(MyApp.navigatorKey.currentContext!,
            listen: false)
            .changeJobType(jobTypeModel);
      }
    },
    child: Container(
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          // border:
          //     jobTypeModel.isSelected ? Border.all(color: Colors.grey) : null,
          borderRadius: BorderRadius.circular(4),
          boxShadow: jobTypeModel.isSelected
              ? [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 1)
                ]
              : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          mainAxisAlignment:
              isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Image.asset(
              jobTypeModel.keyName == 'Assigned'
                  ? 'assets/site_icon.png'
                  : jobTypeModel.keyName.contains('Open')
                      ? 'assets/open_jobs.png'
                      : jobTypeModel.keyName.contains('Pending')
                          ? 'assets/pending_jobs.png'
                          : jobTypeModel.keyName.contains('Completed')
                              ? 'assets/completed_jobs.png'
                              : 'assets/closed_jobs.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 9,
            ),
            Text(jobTypeModel.count.toString(),
                style: Theme.of(MyApp.navigatorKey.currentContext!)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                        fontWeight: jobTypeModel.isSelected
                            ? FontWeight.bold
                            : FontWeight.normal)),
            const SizedBox(
              width: 6,
            ),
            Text(
              jobTypeModel.displayName,
              style: Theme.of(MyApp.navigatorKey.currentContext!)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                      fontWeight: jobTypeModel.isSelected
                          ? FontWeight.bold
                          : FontWeight.normal),
            )
          ],
        )),
  );
}
