import 'package:flutter/material.dart';
import 'package:travelui/ui/components/tourcard.dart';

class ToursPage extends StatefulWidget {
  @override
  _ToursPageState createState() => new _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  @override
  Widget build(BuildContext context) {
    final double barHeight = 66.0;

    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: statusbarHeight + barHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromRGBO(50, 145, 249, 1.0),
                      Color.fromRGBO(72, 197, 247, 1.0)
                    ])),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: statusbarHeight + barHeight,
                    color: Colors.white10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        "Tours",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(50, 145, 249, 1.0),
                    Color.fromRGBO(72, 197, 247, 1.0)
                  ])),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 0.0),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      TourCard(image: "assets/greece.jpg", title: "Greece",),
                      TourCard(image: "assets/unitedstates.jpeg", title: "United States",),
                      TourCard(image: "assets/unitedkingdom.jpg", title: "United Kingdom",)
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top:
                (MediaQuery.of(context).size.height) * 1 / 6 + barHeight - 25.0,
            left: 18.0,
            right: 18.0,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60.0,
                  padding: EdgeInsets.only(left: 24.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.2,
                            blurRadius: 2.0)
                      ]),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 25.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.grey, fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
