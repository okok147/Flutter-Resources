
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app_curved_nav_bar/Homepage.dart';
import 'package:flutter_app_curved_nav_bar/Emotion.dart';
import 'package:flutter_app_curved_nav_bar/Profile.dart';

void main() => runApp(MaterialApp(home:BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _page = 0;

  final _pageOption = [
    Homepage(),
    Emotion(),
    Profile(),
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
        bottomNavigationBar: CurvedNavigationBar(

          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container (
          color: Colors.blueAccent,
          child: Center (
            child: Text(_page.toString(),textScaleFactor: 10.0),
          ),
        )
    );
  }





}