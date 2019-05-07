
import 'package:flutter/material.dart';
import 'package:project/screens/onboard_widget.dart';


class ScooterWidget extends StatelessWidget {
  
  void onSearchPressed(BuildContext context) {
  
  }
  
  void onBackPressed(BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardWidget()));
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 1057,
                      child: Image.asset(
                        "assets/images/map.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 359,
                    top: 8,
                    right: 571,
                    bottom: 267,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(right: 297),
                          child: Container(),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 25,
                            height: 19,
                            margin: EdgeInsets.only(left: 29, top: 14),
                            child: FlatButton(
                              onPressed: () => this.onBackPressed(context),
                              color: Colors.transparent,
                              textColor: Color.fromARGB(255, 0, 0, 0),
                              padding: EdgeInsets.all(0),
                              child: Image.asset("assets/images/back.png",),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 315,
                            height: 56,
                            margin: EdgeInsets.only(top: 21),
                            child: FlatButton.icon(
                              icon: Image.asset("assets/images/group-2-2.png",),
                              label: Text(
                                "Search nearest bikes available.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Avenir",
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () => this.onSearchPressed(context),
                              color: Color.fromARGB(255, 29, 31, 39),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 35,
                            height: 43,
                            margin: EdgeInsets.only(top: 41, right: 403),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    height: 43,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            height: 38,
                                            child: Image.asset(
                                              "assets/images/oval.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 3,
                                          right: 8,
                                          child: Container(
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 250, 250, 247),
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 19,
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 255, 0, 91),
                                              border: Border.all(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                        Positioned(
                                          top: 1,
                                          right: 2,
                                          child: Text(
                                            "12",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              fontSize: 10,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.w800,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  right: 13,
                                  child: Container(
                                    height: 8,
                                    child: Image.asset(
                                      "assets/images/bicycle.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 130,
                          margin: EdgeInsets.only(left: 30, top: 21, right: 327),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 35,
                                  height: 43,
                                  margin: EdgeInsets.only(top: 12),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                          height: 38,
                                          child: Image.asset(
                                            "assets/images/oval.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 3,
                                        right: 8,
                                        child: Container(
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 250, 250, 247),
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 9,
                                        right: 15,
                                        child: Container(
                                          height: 10,
                                          child: Image.asset(
                                            "assets/images/shape-2.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 19,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 255, 0, 91),
                                            border: Border.all(
                                              color: Color.fromARGB(255, 255, 255, 255),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 5,
                                        child: Text(
                                          "6",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontSize: 10,
                                            fontFamily: "Avenir",
                                            fontWeight: FontWeight.w800,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  margin: EdgeInsets.only(left: 4),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          height: 130,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 16,
                                                right: 16,
                                                child: Opacity(
                                                  opacity: 0.1,
                                                  child: Container(
                                                    height: 98,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment(0.36, 0.16),
                                                        end: Alignment(0.78, 0.82),
                                                        stops: [
                                                          0,
                                                          1,
                                                        ],
                                                        colors: [
                                                          Color.fromARGB(255, 252, 157, 88),
                                                          Color.fromARGB(255, 235, 131, 58),
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(49)),
                                                    ),
                                                    child: Container(),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                child: Opacity(
                                                  opacity: 0.05,
                                                  child: Container(
                                                    height: 130,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment(0.36, 0.16),
                                                        end: Alignment(0.78, 0.82),
                                                        stops: [
                                                          0,
                                                          1,
                                                        ],
                                                        colors: [
                                                          Color.fromARGB(255, 252, 157, 88),
                                                          Color.fromARGB(255, 235, 131, 58),
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(65)),
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
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(0.36, 0.16),
                                              end: Alignment(0.78, 0.82),
                                              stops: [
                                                0,
                                                1,
                                              ],
                                              colors: [
                                                Color.fromARGB(255, 252, 157, 88),
                                                Color.fromARGB(255, 235, 131, 58),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(96, 234, 130, 57),
                                                offset: Offset(0, 5),
                                                blurRadius: 10,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(Radius.circular(16)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          child: Image.asset(
                                            "assets/images/path.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 35,
                                  height: 43,
                                  margin: EdgeInsets.only(top: 53),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 43,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                  height: 38,
                                                  child: Image.asset(
                                                    "assets/images/group-3.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 19,
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 255, 0, 91),
                                                    border: Border.all(
                                                      color: Color.fromARGB(255, 255, 255, 255),
                                                      width: 2,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                                        child: Text(
                                                          "3",
                                                          style: TextStyle(
                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                            fontSize: 10,
                                                            fontFamily: "Avenir",
                                                            fontWeight: FontWeight.w800,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 8,
                                        right: 13,
                                        child: Container(
                                          height: 8,
                                          child: Image.asset(
                                            "assets/images/shape.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 44,
                            height: 44,
                            margin: EdgeInsets.only(top: 5, right: 327),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 29, 30, 39),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 36, 38, 51),
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 22,
                                  margin: EdgeInsets.symmetric(horizontal: 11),
                                  child: Image.asset(
                                    "assets/images/outlined-ui-map-target.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 315,
                            height: 334,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 29, 30, 39),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 36, 38, 51),
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                width: 315,
                height: 334,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 29, 30, 39),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 36, 38, 51),
                      offset: Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(left: 24, top: 29, right: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 145,
                              height: 45,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: Text(
                                        "Xiaomi Mijia",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 20,
                                          letterSpacing: 0.21,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 23,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        "Light Pavement e-Scooter",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontSize: 12,
                                          letterSpacing: 0.14,
                                          fontFamily: "Avenir",
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "\$1.5./hr",
                              style: TextStyle(
                                color: Color.fromARGB(255, 44, 195, 248),
                                fontSize: 20,
                                letterSpacing: 0.21,
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 149,
                        height: 30,
                        margin: EdgeInsets.only(left: 24, top: 13),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 16,
                                height: 24,
                                margin: EdgeInsets.only(top: 4),
                                child: Image.asset(
                                  "assets/images/battery.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Power\n93 %",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 142, 142, 147),
                                    fontSize: 10,
                                    letterSpacing: 0.74,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 20,
                                height: 26,
                                margin: EdgeInsets.only(left: 24, top: 3),
                                child: Image.asset(
                                  "assets/images/nearby.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Nearby\n3.4 KM",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 142, 142, 147),
                                    fontSize: 10,
                                    letterSpacing: 0.74,
                                    fontFamily: "Avenir",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 88,
                      margin: EdgeInsets.only(left: 24, top: 25, right: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 130,
                              height: 88,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 29, 30, 39),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/photo.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 130,
                              height: 88,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 29, 30, 39),
                                    offset: Offset(0, 5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/photo-2.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 56,
                      margin: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 267,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.34, 0.47),
                                  end: Alignment(0.8, 0.5),
                                  stops: [
                                    0,
                                    1,
                                  ],
                                  colors: [
                                    Color.fromARGB(255, 252, 157, 88),
                                    Color.fromARGB(255, 235, 131, 58),
                                  ],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Container(),
                            ),
                          ),
                          Positioned(
                            left: 24,
                            right: 24,
                            bottom: 18,
                            child: Container(
                              height: 19,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "SHOW DETAILS",
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
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      width: 22,
                                      height: 12,
                                      margin: EdgeInsets.only(bottom: 4),
                                      child: Image.asset(
                                        "assets/images/right-arrow.png",
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}