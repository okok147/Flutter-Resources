import 'package:flutter/material.dart';
import 'package:maugost/screens/homePage.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';

class DisplayContainer extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final double rating;
  final Color textColor;
  final Color ratingColor;
  final Function onClicked;

  const DisplayContainer(
      {Key key,
      this.title,
      this.textColor = Colors.white,
      this.onClicked,
      this.price,
      this.rating,
      this.ratingColor,
      this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onClicked,
      child: new Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: textColor,
                  shadows: [new Shadow(color: Colors.black, blurRadius: 10)],
                  fontSize: 22),
            ),
            new SizedBox(
              height: 10,
            ),
            new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  child: new Text(
                    "\$ $price",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor, fontSize: 12),
                  ),
                ),
                new SizedBox(
                  width: 10,
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      "4.5",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    new Icon(
                      Icons.star,
                      color: Colors.orange[600],
                      size: 15,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<DisplayContainer> displayList = [
  new DisplayContainer(
    title: "E-Commerce App",
    image: images1,
    price: 80.90,
  ),
  new DisplayContainer(
    title: "Udemy App",
    image: images2,
    price: 120.80,
  ),
  new DisplayContainer(
    title: "Traveling",
    image: images3,
    price: 150.70,
  ),
  new DisplayContainer(
    title: "Navigation",
    image: images4,
    price: 200.60,
  ),
];
