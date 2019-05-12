
import 'package:flutter/material.dart';


class CongratsWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 458,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      width: 375,
                      height: 458,
                      child: Image.asset(
                        "assets/images/asset-23x-8-3.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 31,
                    right: 0,
                    bottom: 76,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Congratulations",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 32,
                              fontFamily: "",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 244,
                          margin: EdgeInsets.only(left: 170, top: 23),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 178,
                                  height: 230,
                                  child: Image.asset(
                                    "assets/images/asset-28x-8.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 164,
                                  height: 216,
                                  margin: EdgeInsets.only(top: 28),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Container(
                                            width: 106,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(255, 143, 91, 120),
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 15, right: 54),
                                          child: Opacity(
                                            opacity: 0.7,
                                            child: Container(
                                              width: 106,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 143, 91, 120),
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
                                          width: 164,
                                          height: 16,
                                          margin: EdgeInsets.only(top: 153),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 12),
                                                  child: Opacity(
                                                    opacity: 0.5,
                                                    child: Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(255, 118, 94, 139),
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      ),
                                                      child: Container(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Opacity(
                                                  opacity: 0.7,
                                                  child: Container(
                                                    width: 136,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 118, 94, 139),
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              width: 106,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 118, 94, 139),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Container(),
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
                                  color: Color.fromARGB(255, 118, 94, 139),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Container(),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 257,
                            height: 36,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 3,
                                  top: 1,
                                  right: 3,
                                  child: Text(
                                    "Today is your day.",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 34,
                                      fontFamily: "",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Positioned(
                                  left: 109,
                                  top: 1,
                                  child: Container(
                                    width: 4,
                                    height: 5,
                                    child: Image.asset(
                                      "assets/images/rectangle.png",
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 315,
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "By our calculations you are a root mom! so we want to thank you for existing.\n\nHappy Mothers Day.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 117, 122, 123),
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
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 166,
                              child: Image.asset(
                                "assets/images/rectangle-copy-2-2.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              width: 197,
                              height: 136,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 35,
                                    right: 0,
                                    child: Container(
                                      height: 84,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: 72,
                                              height: 76,
                                              margin: EdgeInsets.only(top: 7),
                                              child: Image.asset(
                                                "assets/images/1-2.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: 64,
                                              height: 84,
                                              child: Image.asset(
                                                "assets/images/1.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 39,
                                    child: Container(
                                      width: 108,
                                      height: 136,
                                      child: Image.asset(
                                        "assets/images/asset-23x-8.png",
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
                  ),
                  Positioned(
                    left: 30,
                    bottom: 26,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 219, 225, 228),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
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
    );
  }
}