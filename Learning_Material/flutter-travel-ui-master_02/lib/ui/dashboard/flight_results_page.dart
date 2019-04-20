import 'package:flutter/material.dart';

class FlightResultsPage extends StatefulWidget {
  @override
  _FlightResultsPageState createState() => new _FlightResultsPageState();
}

class _FlightResultsPageState extends State<FlightResultsPage> {
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
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Flight Results",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Your travel price : 700\$",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      Container(
                        width: 120.0,
                        height: 35.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        child: Text(
                          "I Can Book",
                          style: TextStyle(color: Colors.blue, fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
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
                          height: 160.0,
                          width: double.infinity,
                          color: Colors.white,
                          child: Card(
                            elevation: 3.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "Minimum Price : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16.0)),
                                      TextSpan(
                                          text: "\n 400 \$",

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              letterSpacing: 0.5))
                                    ]),
                                  ),
                                ),
                                Container(
                                  width: 100.0,
                                  height: 35.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(50, 145, 249, 1.0),
                                        Color.fromRGBO(72, 197, 247, 1.0)
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  child: Text(
                                    "I Can Book",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 6.0, top: 18.0),
                          height: 160.0,
                          width: double.infinity,
                          color: Colors.white,
                          child: Card(
                            elevation: 3.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "Average Price : ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16.0)),
                                      TextSpan(
                                          text: " \n 600 \$",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              letterSpacing: 0.5))
                                    ]),
                                  ),
                                ),
                                Container(
                                  width: 100.0,
                                  height: 35.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(50, 145, 249, 1.0),
                                        Color.fromRGBO(72, 197, 247, 1.0)
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  child: Text(
                                    "I Can Book",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                )
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
                    elevation: 3.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Maximum Price : ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 16.0)),
                            TextSpan(
                                text: "800 \$",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    letterSpacing: 0.5))
                          ]),
                        ),
                        Container(
                          width: 100.0,
                          height: 35.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(50, 145, 249, 1.0),
                                Color.fromRGBO(72, 197, 247, 1.0)
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: Text(
                            "I Can Book",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(top: 6.0),
                ),

                GestureDetector(

                  onTap: (){

                  },
                  child: Container(
                    height: 60.0,

                    width: MediaQuery.of(context).size.width - 48.0,
                    margin: EdgeInsets.only(left: 36.0, right: 36.0, top: 36.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(50, 145, 249, 1.0),
                          Color.fromRGBO(72, 197, 247, 1.0)
                        ])),
                    alignment: Alignment.center,
                    child: Text(
                      "Find Now",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
