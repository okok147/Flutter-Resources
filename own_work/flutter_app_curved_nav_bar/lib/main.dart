import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app_curved_nav_bar/Homepage.dart';
import 'package:flutter_app_curved_nav_bar/Emotion.dart';
import 'package:flutter_app_curved_nav_bar/Profile.dart';


void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectPage = 0;

  final _pageOption = [

    Homepage(),
    Emotion(),
    Profile(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: _pageOption[_selectPage],



        bottomNavigationBar: CurvedNavigationBar(



          onTap: (index) {
            setState(() {
              _selectPage = index;
            });
          },
          initialIndex: 0,


          items: <Widget>[
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