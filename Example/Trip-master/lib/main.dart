import 'package:flutter/material.dart';

import 'detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu, color: Colors.black, size: 30.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 25.0),
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          image: DecorationImage(
                              image: AssetImage("assets/images/profil.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "Destination",
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    "OPTIMAL ENJOY JOURNEY",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .55,
                  width: MediaQuery.of(context).size.height * .53,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                                image: AssetImage('assets/images/photo1.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .3,
                        right: 0,
                        left: 0,
                        child: Container(
                          height: 100.0,
                          margin: EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "May 06-2018",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "Yellow Sea",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 44.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2.5,
                        right: 0,
                        left: 20.0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    height: 45.0,
                                    width: 45.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 3.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/profil.jpg"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  child: Container(
                                    height: 45.0,
                                    width: 45.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 3.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/girl2.jpg"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                ),
                                Positioned(
                                  left: 60,
                                  child: Container(
                                    height: 45.0,
                                    width: 45.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 3.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/guy.png"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.0, top: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text("OTHER TRIPS"),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildRow(
                    context,
                    "assets/images/grid1.jpg",
                    "assets/images/grid2.png",
                    "May 06-2018",
                    "Mauritania",
                    "Aug 11-2017",
                    "Beaufort Sea"),
                _buildRow(
                     context,
                    "assets/images/grid3.png",
                    "assets/images/grid4.png",
                    "May 06-2018",
                    "Mauritania",
                    "March 30-2018",
                    "Yana Bay"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String imageUrl1, String imageUrl2,
      String date1, String title1, String date2, String title2) {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage(
                imageUrl: imageUrl1,
                date: date1,
                title: title1,
              )));
            },
            child: Container(
              height: MediaQuery.of(context).size.width * .5,
              width: MediaQuery.of(context).size.width * .42,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageUrl1), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: MediaQuery.of(context).size.height * .18,
                    right: 0,
                    left: 10.0,
                    child: Container(
                      height: 60.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            date1,
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            title1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage(
                imageUrl: imageUrl2,
                date: date2,
                title: title2,
              )));
            },
            child: Container(
              height: MediaQuery.of(context).size.width * .5,
              width: MediaQuery.of(context).size.width * .42,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imageUrl2), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: MediaQuery.of(context).size.height * .18,
                    right: 0,
                    left: 10.0,
                    child: Container(
                      height: 60.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            date2,
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            title2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
