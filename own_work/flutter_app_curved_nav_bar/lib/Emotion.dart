import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new Emotion(),

    //direct to another routes
    routes: <String,WidgetBuilder>{
      "/BottomNavBar" :(BuildContext context) => new Emotion(),

    },

  ));
}

class Emotion extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<Emotion> {
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

          area: Rect.fromLTWH(thirdOfWidth*1.4, 212.0, animationWidth / 1.45 , animationHeight / 2),
          guardComingFrom: ['Activate'],

          animationsToCycle: ['Off','On'],
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
              filename: 'assets/emotion.flr',


              activeAreas: activeAreas,


            )));
  }
}

