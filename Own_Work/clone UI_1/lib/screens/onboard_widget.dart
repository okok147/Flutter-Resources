
import 'package:flutter/material.dart';
import 'package:project/screens/scooter_widget.dart';


class OnboardWidget extends StatelessWidget {
  
  void onNEXTPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => ScooterWidget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 36, 38, 51),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              top: 91,
              right: 0,
              bottom: 29,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 375,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 11,
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 375,
                            child: Image.asset(
                              "assets/images/illustration.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 6,
                          top: 255,
                          child: Container(
                            width: 15,
                            height: 5,
                            child: Image.asset(
                              "assets/images/fill-3415.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 253,
                          child: Container(
                            width: 12,
                            height: 14,
                            child: Image.asset(
                              "assets/images/fill-3416.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 60, top: 101),
                      child: Text(
                        "In hac habitasse platea dictumst.",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 259,
                      margin: EdgeInsets.only(left: 60, bottom: 115),
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          "Donec facilisis tortor ut augue lacinia, at viverra est semper. ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            letterSpacing: 0.21,
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 19,
                    margin: EdgeInsets.only(left: 60, right: 61),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Opacity(
                            opacity: 0.5,
                            child: Text(
                              "SKIP",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                                letterSpacing: 0.94,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 41,
                            height: 19,
                            child: FlatButton(
                              onPressed: () => this.onNEXTPressed(context),
                              color: Colors.transparent,
                              textColor: Color.fromARGB(255, 234, 130, 57),
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "NEXT",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w800,
                                ),
                                textAlign: TextAlign.right,
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
              bottom: 25,
              child: Container(
                width: 65,
                height: 24,
                child: Image.asset(
                  "assets/images/pagination.png",
                  fit: BoxFit.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}