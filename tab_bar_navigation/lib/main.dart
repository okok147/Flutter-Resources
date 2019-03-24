import 'package:flutter/material.dart';
import './FirstPage.dart' as first;
import './SecondPage.dart' as second;
import './ThirdPage.dart' as third;

void main() {
  runApp(new MaterialApp(
      home: new MyTabs()
  ));
}

class MyTabs extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {


  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Pages"),
            backgroundColor: Colors.blueAccent,

        ),

      bottomNavigationBar: new Material(
        color: Colors.black54,
        child: new TabBar(

            controller: controller,
            tabs: <Tab>[
        new Tab(icon: new Icon(Icons.closed_caption)),
        new Tab(icon: new Icon(Icons.favorite)),
        new Tab(icon: new Icon(Icons.shopping_cart)),

      ]

        ),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[

          new first.First(),
          new second.Second(),
          new third.Third(),
          new Tab(icon: new Icon(Icons.closed_caption)),
          new Tab(icon: new Icon(Icons.favorite)),
          new Tab(icon: new Icon(Icons.shopping_cart)),




        ],
      )
    );
  }
}


