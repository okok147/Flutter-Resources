import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app_curved_nav_bar/Homepage.dart';
import 'package:flutter_app_curved_nav_bar/Emotion.dart';
import 'package:flutter_app_curved_nav_bar/Profile.dart';
import 'package:smart_flare/smart_flare.dart';

void main() {
  runApp(new MaterialApp(
    home:new HomePage(),
    //it can direct you to another routes
    routes: <String,WidgetBuilder> {
      "/BottomNavBar" :(BuildContext context) => new BottomNavBar(),


    },
  ));
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(


      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new IconButton(icon: new Icon(MdiIcons.fromString('fingerprint'),color: Colors.lightBlue,),
                  iconSize: 100.0,
                  //set the routes you want to go here
                  onPressed: () {Navigator.of(context).pushNamed("/BottomNavBar");}
              ),
              new Text("Login",style: TextStyle(fontStyle: FontStyle.italic),)

            ],
          ),
        ),
      ),
    );
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
