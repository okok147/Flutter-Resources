import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:clone_travel_ui/ui/dashboard/home_page.dart';

void main() => runApp(MaterialApp(home: DashboardPage()));

class DashboardPage extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<DashboardPage> {
  int _selectpage = 0;

  final _pageOption = [

    HomePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(






      body: _pageOption[_selectpage],





      bottomNavigationBar: CurvedNavigationBar(







        onTap: (index) {

          setState(() {
            _selectpage = index;
          });

        },



        items: <Widget >[




          Icon(Icons.home, size: 30),
          Icon(MdiIcons.fromString('emoticon'), size: 30),
          Icon(MdiIcons.fromString('face'), size: 30),
        ],
        color: Colors.black12,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.lightBlueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),



      ),




    );
  }
}