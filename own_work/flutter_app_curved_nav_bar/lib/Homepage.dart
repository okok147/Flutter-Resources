import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';


void main() {
  runApp(new MaterialApp(

    home: new Homepage(),

    //direct to another routes


  ));
}

class Homepage extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {




    var activeAreas = [
      // Insert top-left

      // Insert middle
      ActiveArea(
        // debugArea: true,
          debugArea: false,

          area: Rect.fromLTWH(80,70,200,200),
          guardComingFrom: ['Activiate'],

          animationsToCycle: ['to 6','Outer Windows Highlight','to 5','Center Window Highlight','to 4','Inner Windows Highlight','to 3'],
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


            child: SmartFlareActor(

              filename: 'assets/home.flr',
              startingAnimation: 'Sun Rotate' ,
              height: 100.0,
              width: 100.0,



              activeAreas: activeAreas,




            )

        ));
  }
}

