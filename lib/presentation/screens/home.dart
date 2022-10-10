import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/drawers/home_drawer.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/presentation/screens/profile.dart';
import 'package:nn_portal/presentation/screens/logs/logs.dart';
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
    _tabController=TabController(length: 3, vsync: this);

  }
  void _onItemTapped(int index) {
    setState(() {
      _tabController!.animateTo(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   centerTitle: true,
      // ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children:  [
          JobList(),
          Logs(),
          Profile(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: _bottomNavigationBar(),

    );
  }

  BottomNavigationBar _bottomNavigationBar()
  {
    return BottomNavigationBar(
      items:const  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Jobs',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Record',
          backgroundColor:  Colors.white,
        ),
        BottomNavigationBarItem(
          icon:  Icon(Icons.person),
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
      onTap: _onItemTapped
    );
  }
}
