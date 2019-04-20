import 'package:flutter/material.dart';
import 'package:clone_travel_ui/ui/components/customtextformfield.dart';

class PlaneTicketPage extends StatefulWidget {
  ValueChanged<void> onPush;

  PlaneTicketPage({Key key, this.onPush}) : super(key: key);
  @override
  _PlaneTicketPageState createState() => new _PlaneTicketPageState();
}

class _PlaneTicketPageState extends State<PlaneTicketPage> {
  @override
  Widget build(BuildContext context) {
    final double barHeight = 66.0;

    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: Column(
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
                          "Plane Ticket",
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
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(50, 145, 249, 1.0),
                        Color.fromRGBO(72, 197, 247, 1.0)
                      ])),
                  alignment: Alignment.center,
                ),
                Positioned(
                  bottom: -1.0,
                  child: ClipOval(
                    child: Container(
                      height: 120.0,
                      width: 120.0,
                      color: Colors.white,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset("assets/falcon.png", alignment: Alignment.center,height: 50.0, width: 50.0,)),
                    ),
                    clipper: CustomContainerClipper(),

                  ),
                )
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 24.0, left: 18.0, right: 18.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(50, 145, 249, 1.0),
                                  Color.fromRGBO(72, 197, 247, 1.0)
                                ]),
                              ),
                              child: Center(
                                  child: Text(
                                    "Round",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                    "One Way",
                                    style: TextStyle(color: Colors.grey),
                                  ))),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                    "Multi",
                                    style: TextStyle(color: Colors.grey),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "From", icon: Icons.location_on),
                        ),
                        Container(
                          width: 18.0,
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "To", icon: Icons.location_on),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 6.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "Departure  Date", icon: Icons.date_range),
                        ),
                        Container(
                          width: 18.0,
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "Return Date", icon: Icons.date_range),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 6.0),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "No Of Passengers",
                              icon: Icons.person_add),
                        ),
                        Container(
                          width: 18.0,
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomTexFormField(
                              label: "Flight Class", icon: Icons.class_),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onPush(context);
                    },


                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width - 100.0,
                      margin:
                      EdgeInsets.only(left: 36.0, right: 36.0, top: 36.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(50, 145, 249, 1.0),
                            Color.fromRGBO(72, 197, 247, 1.0)
                          ])),
                      alignment: Alignment.center,
                      child: Text(
                        "Search Flights",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomContainerClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTWH(0.0, size.width / 2, size.width, size.height);

    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}