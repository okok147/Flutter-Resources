import 'package:flutter/material.dart';

var images = ["assets/light.png", "assets/tv.png"];
var title = ["Lights", "Smart Tv"];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xFFA4B4A9),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/lamp.png"),
            ),
            Positioned(
              top: 80,
              left: 25,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back,
                            color: Colors.white, size: 30),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.settings, color: Colors.white, size: 30),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Office",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: "Proxima-Nova-XBold"),
                  ),
                  Text("6 Devices Active",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Color(0xFFFF9B52),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.timelapse, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text("23°c",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Proxima-Nova-Bold"))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 30, bottom: 50),
                child: SizedBox(
                  height: 270,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(left: 16, right: 8, bottom: 40),
                        child: Container(
                          width: 180,
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 10),
                                    blurRadius: 10)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xFFECECEC),
                                    shape: BoxShape.circle),
                                child: Image.asset(images[index]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(title[index],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "Proxima-Nova-Bold"))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 180,
              bottom: 10,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "Proxima-Nova-Bold"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
