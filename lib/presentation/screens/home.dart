import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/login_alert.dart';
import 'package:nn_portal/presentation/drawers/home_drawer.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/presentation/screens/profile.dart';
import 'package:nn_portal/presentation/screens/logs/logs.dart';
import 'package:nn_portal/presentation/screens/teams/team_list.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onItemTapped(int index) {
    if (Provider.of<AuthenticationProvider>(context, listen: false)
        .userModel!
        .isGuest!) {
      showLoginAlert();

    } else {
      if (_tabController?.index != 0 && index == 0) {
        Provider.of<JobsProvider>(MyApp.navigatorKey.currentContext!,
                listen: false)
            .resetToAllJobs();
      }
      setState(() {
        _tabController!.animateTo(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   centerTitle: true,
      // ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const JobList(),
          Provider.of<AuthenticationProvider>(context, listen: false)
                      .userModel!
                      .roleId! ==
                  1
              ? TeamList()
              : const Logs(),
          Profile(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Jobs',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Provider.of<AuthenticationProvider>(context, listen: false)
                        .userModel!
                        .roleId! ==
                    1
                ? const Icon(Icons.group_add)
                : const Icon(Icons.access_time),
            label: Provider.of<AuthenticationProvider>(context, listen: false)
                        .userModel!
                        .roleId! ==
                    1
                ? 'Teams'
                : 'Record',
            backgroundColor: Colors.white,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _tabController!.index,
        selectedItemColor: AppColors.primaryBase,
        backgroundColor: Colors.white,
        // unselectedItemColor: AppColors.textLightFifth,
        // selectedItemColor: AppColors.textLight,
        // backgroundColor: AppColors.primaryBase,
        onTap: _onItemTapped);
  }
}
