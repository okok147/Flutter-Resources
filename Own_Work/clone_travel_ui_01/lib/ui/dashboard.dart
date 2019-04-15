import 'package:flutter/material.dart';


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

  ];

  void _selectedTab(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async =>
      !await navigatorKeys[_selected].currentState.maybePop(),
      child: Scaffold(
        body: _children[_selected],

      ),
    );
  }
}