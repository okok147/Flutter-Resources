import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String imageUrl;
  final String date;
  final String title;
  DetailPage({this.imageUrl, this.date, this.title});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.imageUrl), fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 30.0,
                right: 30.0,
                child: Container(
                  height: 45.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white.withOpacity(.3)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white, size: 30.0),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .5,
                right: 0,
                left: 20.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.date,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        widget.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        "The ${widget.title} is the mostimportant gulf of the Laptev Sea. It is located between Cape Buor-Khaya on its westerne side and the Edbelyak Bay at its eastern end.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .8,
                left: 0,
                right: 0,
                child: Container(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.white.withOpacity(.2)
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/girl2.jpg"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(50.0)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Ayla",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.white.withOpacity(.2)
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/guy.png"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(50.0)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Jermaine",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50.0,
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.white.withOpacity(.2)
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/girl3.jpg"),
                                  fit: BoxFit.cover
                                ),
                                borderRadius: BorderRadius.circular(50.0)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Luna",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
