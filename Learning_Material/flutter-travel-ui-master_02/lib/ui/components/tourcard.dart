

import 'package:flutter/material.dart';

class TourCard extends StatelessWidget {

  final String image;
  final String title;

  const TourCard({Key key, this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: double.infinity,
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                image,
                fit: BoxFit.cover,

              ),

              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black38,
                alignment: Alignment.center,
                child: Text(title, style: TextStyle(color: Colors.white70, fontSize: 24.0, letterSpacing: 1.5),),
              )
            ],
          )),
    );
  }
}
