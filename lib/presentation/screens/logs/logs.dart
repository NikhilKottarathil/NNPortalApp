import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/log_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/drawers/home_drawer.dart';
import 'package:nn_portal/presentation/screens/logs/add_log.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:provider/provider.dart';

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (value) {
          Provider.of<LogProvider>(context, listen: false)
              .changSelectedDate(value);
        },
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now(),
        backButton: false,
        fullCalendar: true,
        accent: AppColors.primaryBase,
        padding: 20,
      ),
      drawer: HomeDrawer(),
      body: Consumer<LogProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: value.models.isNotEmpty
                    ? ListView.separated(
                        itemCount: value.models.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => AddLog(logType: value.models[index].logType,logModel: value.models[index],)));                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>const JobDetails()));
                              },
                              child: LogTile(logModel: value.models[index]));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                      )
                    : const NoItemsFound(),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: floatingActionBubble(),
    );
  }

  FloatingActionBubble floatingActionBubble() {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: "Vehicle Log ",
          iconColor: Colors.white,
          bubbleColor: AppColors.primaryBase,
          icon: Icons.add,
          titleStyle: Theme.of(context)
              .textTheme
              .button!
              .apply(color: AppColors.textLight),
          onPress: () {
            _animationController!.reverse();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddLog(logType: LogType.vehicleLog,)));
          },
        ),
        Bubble(
          title: "Tool Log    ",
          iconColor: Colors.white,
          bubbleColor: AppColors.primaryBase,
          icon: Icons.add,
          titleStyle: Theme.of(context)
              .textTheme
              .button!
              .apply(color: AppColors.textLight),
          onPress: () {
            _animationController!.reverse();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddLog(logType: LogType.toolLog,)));
          },
        ),
        Bubble(
          title: "Site Log    ",
          iconColor: Colors.white,
          bubbleColor: AppColors.primaryBase,
          icon: Icons.add,
          titleStyle: Theme.of(context)
              .textTheme
              .button!
              .apply(color: AppColors.textLight),
          onPress: () {

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddLog(logType: LogType.siteLog,)));
            _animationController!.reverse();
          },
        ),
        Bubble(
          title: "Work Log",
          iconColor: Colors.white,
          bubbleColor: AppColors.primaryBase,
          icon: Icons.add,
          titleStyle: Theme.of(context)
              .textTheme
              .button!
              .apply(color: AppColors.textLight),
          onPress: () {
            _animationController!.reverse();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddLog(logType: LogType.workLog,)));
          },
        ),
      ],
      animation: _animation!,
      onPress: () => _animationController!.isCompleted
          ? _animationController!.reverse()
          : _animationController!.forward(),
      iconColor: AppColors.textLight,
      animatedIconData: AnimatedIcons.menu_close,
      backGroundColor: AppColors.primaryBase,
    );
  }
}