import 'package:flutter/material.dart';
import 'package:travelui/ui/dashboard/planeticket_page.dart';

class HomePage extends StatefulWidget {

   ValueChanged<void> onPush;

   HomePage({Key key, this.onPush}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        "Home",
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
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(50, 145, 249, 1.0),
                    Color.fromRGBO(72, 197, 247, 1.0)
                  ])),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "You will travel by?",
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height) * 2 / 7,
            left: 18.0,
            right: 18.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 6.0, top: 18.0),
                          height: 180.0,
                          width: double.infinity,
                          color: Colors.white,
                          child: GestureDetector(
                              onTap: (){

                                print("TAP");
                                widget.onPush(context);
                              },

                              child: Card(

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/falcon.png", alignment: Alignment.center,height: 60.0, width: 60.0,)),
                                    Text("Plane", style: TextStyle(fontSize: 18.0),)
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 6.0, top: 18.0),
                          height: 180.0,
                          width: double.infinity,
                          color: Colors.white,
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child: Image.asset("assets/train.png", alignment: Alignment.center,height: 60.0, width: 60.0,)),
                                Text("Train", style: TextStyle(fontSize: 18.0),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset("assets/ford_gt.png", alignment: Alignment.center,height: 60.0, width: 60.0,)),
                        Text("Car", style: TextStyle(fontSize: 18.0),)
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(top: 6.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
