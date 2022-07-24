import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
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

  ScrollController scrollController=ScrollController();
  TextEditingController searchTextEditingController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {

        Provider.of<JobsProvider>(context,listen: false).loadMore();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Find your jobs'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      drawer: HomeDrawer(),
      body:

      Consumer<JobsProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: TextFieldSearch(searchTextEditingController: searchTextEditingController,searchAction: (){
                  Provider.of<JobsProvider>(context,listen: false).searchJobs(searchTextEditingController.text);
                },),
              ),
             const  SizedBox(height: 20,),
              Expanded(
                child: value.models.isNotEmpty
                    ? ListView.separated(
                        itemCount: value.models.length,
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              Provider.of<JobsDetailsProvider>(context,listen: false).setJobModel(jobModel: value.models[index]);
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>const JobDetails()));
                            },
                              child: JobListTile(jobModel: value.models[index]));
                        }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 14,);
                },
                      )
                    : const NoItemsFound(),
              ),

                if(value.pageStatus==PageStatus.loadMore)
                  const CustomCircularProgressIndicator(),
            ],
          ),
        );
      }),
    );
  }
}
