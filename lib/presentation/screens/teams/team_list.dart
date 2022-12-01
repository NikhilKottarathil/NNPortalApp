import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/presentation/components/list_tiles/team_list_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_search.dart';
import 'package:nn_portal/presentation/screens/teams/add_team.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:provider/provider.dart';

class TeamList extends StatelessWidget {
  TeamList({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Consumer<TeamProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldSearch(
                searchTextEditingController: searchTextEditingController,
                hintText: 'Search ',
                onTypingSearchEnable: true,
                searchAction: () {
                  Provider.of<TeamProvider>(context, listen: false)
                      .searchTeams(searchTextEditingController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: value.pageStatus == PageStatus.loading
                    ? const CustomCircularProgressIndicator()
                    : value.displayModel.isNotEmpty
                        ? ListView.separated(
                            itemCount: value.displayModel.length,
                            shrinkWrap: true,
                            controller: scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return TeamListTile(
                                teamModel: value.displayModel[index],
                                siNo: index,
                              );
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
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBase,
        onPressed: () {
          addTeam();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
