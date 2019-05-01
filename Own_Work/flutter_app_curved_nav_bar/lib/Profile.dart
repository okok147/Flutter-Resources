import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';
import 'package:flutter_app_curved_nav_bar/Homepage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app_curved_nav_bar/Emotion.dart';
import 'package:flutter_app_curved_nav_bar/Profile.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Profile(),

    //direct to another routes
    routes: <String,WidgetBuilder>{
      "/BottomNavBar" :(BuildContext context) => new Profile(),

    },

  ));
}

class Profile extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<Profile> {
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

          area: Rect.fromLTWH(thirdOfWidth*0.28, 212.0, animationWidth * 2  , animationHeight * 1),
          guardComingFrom: ['Activate'],


          animationsToCycle: ['human_1','human_2','human_3','human_4','human_5'],
          onAreaTapped: () {



            //New method for direct to another page

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
              width: 300.0,
              height: 500.0,
              filename: 'assets/human_revolution.flr',
              startingAnimation: 'human_1',



              activeAreas: activeAreas,


            )));
  }
}

