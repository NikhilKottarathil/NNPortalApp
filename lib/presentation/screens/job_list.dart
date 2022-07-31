import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_search.dart';
import 'package:nn_portal/presentation/drawers/home_drawer.dart';
import 'package:nn_portal/presentation/screens/job_details.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:provider/provider.dart';

class JobList extends StatefulWidget {
  const JobList({Key? key}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
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
      ),
      // drawer: HomeDrawer(),
      body: Consumer<JobsProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              jobTypeTile(jobTypeModel: value.jobTypeModels[0]),
              const SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                      child: jobTypeTile(jobTypeModel: value.jobTypeModels[1])),
                 const SizedBox(width: 10,),
                  Expanded(
                      child: jobTypeTile(jobTypeModel: value.jobTypeModels[2]))
                ],
              ),
              const SizedBox(height: 10,),

              Row(
                children: [
                  Expanded(
                      child: jobTypeTile(jobTypeModel: value.jobTypeModels[3])),
                  const SizedBox(width: 10,),

                  Expanded(
                      child: jobTypeTile(jobTypeModel: value.jobTypeModels[4]))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 1,
                child: TextFieldSearch(
                  searchTextEditingController: searchTextEditingController,
                  searchAction: () {
                    Provider.of<JobsProvider>(context, listen: false)
                        .searchJobs(searchTextEditingController.text);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: value.pageStatus==PageStatus.loading?CustomCircularProgressIndicator():value.models.isNotEmpty
                    ? ListView.separated(
                        itemCount: value.models.length,
                        // shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Provider.of<JobsDetailsProvider>(context,
                                        listen: false)
                                    .setJobModel(jobModel: value.models[index]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const JobDetails()));
                              },
                              child:
                                  JobListTile(jobModel: value.models[index]));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                      )
                    : const NoItemsFound(),
              ),
              if (value.pageStatus == PageStatus.loadMore)
                const SizedBox(
                    height: 50, child: const CustomCircularProgressIndicator()),
            ],
          ),
        );
      }),
    );
  }
}

Widget jobTypeTile({required JobTypeModel jobTypeModel}) {
  return GestureDetector(
    onTap: (){

      Provider.of<JobsProvider>(MyApp.navigatorKey.currentContext!,listen: false).changeJobType(jobTypeModel);
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,

          border: jobTypeModel.isSelected?Border.all(color: Colors.grey):null,
          borderRadius: BorderRadius.circular(4),

          boxShadow: [
          BoxShadow(color: Colors.grey.shade200.withOpacity(.8),offset: Offset(0,2),spreadRadius: 2,blurRadius: 1)
        ]
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.photo,color: Colors.grey,),
        const SizedBox(
          width: 6,
        ),
        Text(jobTypeModel.count.toString(),
            style: Theme.of(MyApp.navigatorKey.currentContext!)
                .textTheme
                .titleMedium!.copyWith(fontWeight: jobTypeModel.isSelected?FontWeight.bold:FontWeight.normal)),
        const SizedBox(
          width: 6,
        ),
        Text(
          jobTypeModel.displayName,
          style:
              Theme.of(MyApp.navigatorKey.currentContext!).textTheme.titleMedium!.copyWith(fontWeight: jobTypeModel.isSelected?FontWeight.bold:FontWeight.normal),
        )
      ],
    )),
  );
}
