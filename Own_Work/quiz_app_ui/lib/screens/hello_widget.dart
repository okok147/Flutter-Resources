
import 'package:flutter/material.dart';
import 'package:quiz_app_ui/screens/question1_widget.dart';


class HelloWidget extends StatelessWidget {
  
  void onGroupPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => Question1Widget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 428,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 60,
                          top: 0,
                          right: 78,
                          child: Container(
                            height: 428,
                            child: Image.asset(
                              "assets/images/asset-23x-8-8.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 22,
                          right: 0,
                          child: Container(
                            height: 311,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 24,
                                  margin: EdgeInsets.only(left: 46),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Container(
                                            width: 106,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 119, 78, 56),
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Opacity(
                                            opacity: 0.7,
                                            child: Container(
                                              width: 106,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 119, 78, 56),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              ),
                                              child: Container(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 15, right: 59),
                                    child: Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                        width: 106,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 119, 78, 56),
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 33),
                                    child: Text(
                                      "My name is Pitty!",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20,
                                        fontFamily: "",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 58),
                                    child: Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                        width: 106,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 119, 78, 56),
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16, top: 22),
                                    child: Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                        width: 136,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 119, 78, 56),
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 72, right: 171),
                                    child: Opacity(
                                      opacity: 0.7,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 119, 78, 56),
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 191,
                          child: Opacity(
                            opacity: 0.2,
                            child: Container(
                              width: 106,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 119, 78, 56),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 298,
                      margin: EdgeInsets.only(top: 27),
                      child: Text(
                        "Did you know that today is a very special day?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 31, 57, 63),
                          fontSize: 24,
                          fontFamily: "",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 286,
                      margin: EdgeInsets.only(top: 26),
                      child: Text(
                        "I and my friends believe that you are part of it, do you want to find out?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 117, 123, 124),
                          fontSize: 16,
                          fontFamily: "",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 166,
                    margin: EdgeInsets.only(left: 60, right: 78),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 166,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 166,
                                    child: Image.asset(
                                      "assets/images/rectangle-copy-2.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 57,
                                  top: 49,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 42,
                          child: Container(
                            width: 315,
                            height: 46,
                            child: FlatButton(
                              onPressed: () => this.onGroupPressed(context),
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(23))),
                              textColor: Color.fromARGB(255, 30, 56, 62),
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "Find out now",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "",
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              child: Text(
                "Hello!",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 43,
                  fontFamily: "",
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}