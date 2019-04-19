import 'package:flutter/material.dart';
import 'package:clone_travel_ui/ui/components/bottomnavbar.dart';
import 'package:clone_travel_ui/ui/dashboard/explore_page.dart';
import 'package:clone_travel_ui/ui/dashboard/home_page.dart';
import 'package:clone_travel_ui/ui/dashboard/profile_page.dart';
import 'package:clone_travel_ui/ui/dashboard/tours_page.dart';
import 'package:clone_travel_ui/ui/tabnavigations/homenav.dart';

//main > signin_page + signin_page > dashboard(unfinished)


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => new _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
  };

  int _selected = 0;

  List<Widget> _children = [
    HomeTabNavigator(navigatorKey : navigatorKeys[0],),
    //ToursPage(),
    //ExplorePage(),
    //ProfilePage(),


  ];

  void _selectedTab(int index) {
    setState(() {
      _selected = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope (
      onWillPop:  () async =>
      !await navigatorKeys[_selected].currentState.maybePop(),

      child: Scaffold(
        body: _children[_selected],
        bottomNavigationBar: FABBottomAppBar(
          color: Colors.grey,
          selectedColor: Colors.blueAccent,
          onTabSelected: _selectedTab,
          items: [
            BottomAppBarItem(iconData: Icons.add_to_home_screen,text: "Home"),
            BottomAppBarItem(iconData: Icons.beach_access,text: 'Tours'),
            BottomAppBarItem(iconData: Icons.location_searching,text: 'Explore'),
            BottomAppBarItem(iconData: Icons.person_outline,text: 'Profile'),

          ],
        ),
      ),

    );
  }
}