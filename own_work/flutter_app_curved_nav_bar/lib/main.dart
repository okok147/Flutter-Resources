import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:flutter_app_curved_nav_bar/Homepage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app_curved_nav_bar/Emotion.dart';
import 'package:flutter_app_curved_nav_bar/Profile.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
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
    var animationWidth = 185.0;
    var animationHeight = 140.0;
    var thirdOfWidth = animationWidth / 3;
    var activeAreas = [
      // Insert top-left

      // Insert middle
      ActiveArea(
        // debugArea: true,
        debugArea: false,

          area: Rect.fromLTWH(thirdOfWidth*0.5, 0.5, animationWidth , animationHeight / 1),
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

    ];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Align(
            alignment: Alignment.center,
            child: SmartFlareActor(

              width: animationWidth,
              height: animationHeight,
              filename: 'assets/Fingerprint.flr',
              startingAnimation: 'process',
              activeAreas: activeAreas,




            ),),);
  }
}




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