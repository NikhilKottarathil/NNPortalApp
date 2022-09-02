import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/list_tiles/in_hand_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/log_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/screens/logs/add_log.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/in_hand_provider.dart';
import 'package:provider/provider.dart';

class InHand extends StatelessWidget {
  final String parentPage;

  const InHand({Key? key, required this.parentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDefault(title: parentPage),
        body: Consumer<InHandProvider>(builder: (context, value, child) {
          return value.pageStatus == PageStatus.loading
              ? const CustomCircularProgressIndicator()
              : value.models.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemCount: value.models.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {
                              if (!Provider.of<AuthenticationProvider>(context,
                                      listen: false)
                                  .userModel!
                                  .onLeave!) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddLog(
                                          logType: value.models[index].logType,
                                          logModel: value.models[index],
                                        ))).then((value) {
                                  Provider.of<InHandProvider>(context,
                                      listen: false).getData();
                                });
                              }
                              // Provider.of<InHandProvider>(context).onTileTap(index:index);
                            },
                            child: LogTile(logModel: value.models[index]));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    )
                  : const NoItemsFound();
        }));
  }
}
