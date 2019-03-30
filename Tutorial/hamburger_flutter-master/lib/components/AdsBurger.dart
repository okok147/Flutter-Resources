import 'package:flutter/material.dart';
import 'PriceTag.dart';

class AdsBurger extends StatelessWidget {


  Widget build(BuildContext context) {

    //define size of King Size Burger
    double  _imageSize = MediaQuery.of(context).size.width*0.5 - 20;
    double _contentSize = MediaQuery.of(context).size.width*0.4 - 20;
    //String of King Size Burger
    String _url = "https://cdn.vox-cdn.com/thumbor/_C1ugN0jUg2uYg5PQOyz4eumEAY=/0x444:7115x5780/1200x800/filters:focal(0x444:7115x5780)/cdn.vox-cdn.com/uploads/chorus_image/image/49565113/shutterstock_333689708.0.0.jpg";

    return new Container(margin: EdgeInsets.only(left: 10, right: 10), child:
      new Row(children: <Widget>[
        new Container(width: _imageSize, height: _imageSize, child:
            //
          new Stack(children: <Widget>[
            //background of King Size Burger
            new ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)), child:
              new Image.network(
                  //implement String _url in line 12
                 _url, fit: BoxFit.cover, width: _imageSize, height: _imageSize)
            ),
            //for pricetag location padding:
            new Container(padding: EdgeInsets.all(20), child:
              new PriceTag(price: 4.15)
            ),
            new Align(alignment: Alignment.bottomLeft, child:
              new Container(padding: EdgeInsets.all(20), child:
                new Text("AdsBurger.dart", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).indicatorColor))
              )
            )
          ])
        ),
        new Container(margin: EdgeInsets.only(left: 20), width: _contentSize, child:
          new Column(children: <Widget>[
            new Text("King Size Burguer", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
            new Padding(padding: EdgeInsets.only(top: 10), child:
              new Text("AdsBurger.dart", style: TextStyle(fontSize: 12))
            )
          ])
        )
      ])
    );
  }

}