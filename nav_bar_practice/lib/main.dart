import 'package:flutter/material.dart';
import 'package:nav_bar_practice/Home.dart';
import 'package:nav_bar_practice/Work.dart';
import 'package:nav_bar_practice/Landscape.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{


  @override
  State<StatefulWidget> createState(){
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  int _selectPage = 0;
  final _pageOption = [
    HomePage(),
    WorkPage(),
    LandscapePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Bottom Nav Bar Video'),),
        body: _pageOption[_selectPage],
        bottomNavigationBar: CurvedNavigationBar(


          //each index represent a number,when tap,var a number then switch to that page.
          onTap: (int index) {
            setState(() {
              _selectPage = index;
            });
          },



          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
          ],
        ),
      ),
    );
  }

}