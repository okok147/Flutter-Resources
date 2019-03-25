import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(new MaterialApp(
      home: new MyTabs()
  ));
}


class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}



class MyTabsState extends State<MyTabs>  {








  @override
    Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Pages"),
            backgroundColor: Colors.blueAccent,

        ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
      items: <Widget>[
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.compare_arrows, size: 30),

    ],
      onTap: (index){

      },
      ),
      body: new Container(color: Colors.blueAccent),








      );

  }
}


