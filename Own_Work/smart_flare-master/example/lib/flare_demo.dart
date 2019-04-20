import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:flare_tutorial/Homepage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(new MaterialApp(
    home: new FlareDemo(),

    //direct to another routes
    routes: <String,WidgetBuilder>{
      "/BottomNavBar" :(BuildContext context) => new BottomNavBar(),

    },

  ));
}

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {
  @override
  Widget build(BuildContext context) {
    var animationWidth = 295.0;
    var animationHeight = 251.0;
    var thirdOfWidth = animationWidth / 3;
    var activeAreas = [
      // Insert top-left
      RelativeActiveArea(
          debugArea: true,
          area: Rect.fromLTRB(0, 0, 0.35, 0.5),
          guardComingFrom: ['deactivate'],
          animationName: 'camera_tapped',
          onAreaTapped: () {
            print('Camera tapped!');
          }),
      // Insert middle
      ActiveArea(
          // debugArea: true,
          area:
              Rect.fromLTWH(thirdOfWidth, 0, thirdOfWidth, animationHeight / 2),
          guardComingFrom: ['deactivate'],
          animationName: 'pulse_tapped',
          onAreaTapped: () {

            //New method for direct to another page
            Navigator.push(context, new MaterialPageRoute(builder: (context)
            => new BottomNavBar()));
          }),
      // Insert top-right

      // Insert bottom half area
      //it demonstrates how to define the action of flr
      ActiveArea(
          // debugArea: true,
          area: Rect.fromLTWH(
              0, animationHeight / 2, animationWidth, animationHeight / 2),
          animationsToCycle: ['activate', 'deactivate'],
          onAreaTapped: () {
            print('Activate toggles!');
          }),
    ];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 30, 18, 222),
        body: Align(
            alignment: Alignment.bottomCenter,
            child: SmartFlareActor(
              width: animationWidth,
              height: animationHeight,
              filename: 'assets/button-animation.flr',
              startingAnimation: 'deactivate',
              activeAreas: activeAreas,
            )));
  }
}




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectPage = 0;


  final _pageOption = [

    HomePage(),



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