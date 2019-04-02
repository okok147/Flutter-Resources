import 'package:flutter/material.dart';
import 'package:maugost/screens/homePage.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';

class AppsItemBuilder extends StatelessWidget {
  final String heroTag;
  final String title;
  final String image;
  final double price;
  final double rating;
  final Color textColor;
  final Color ratingColor;
  final Function onClicked;

  const AppsItemBuilder(
      {Key key,
      this.title,
      this.textColor = appBlack,
      this.onClicked,
      this.price,
      this.rating,
      this.ratingColor,
      this.image,
      this.heroTag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onClicked,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.1))),
        child: new Row(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(15),
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
                color: Colors.white,
              ),
            ),
            new SizedBox(
              width: 10,
            ),
            new Flexible(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(
                            left: 12, right: 12, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                        child: new Text(
                          "\$ $price",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      new SizedBox(
                        width: 10,
                      ),
                      new Row(
                        children: <Widget>[
                          new Text(
                            "4.5",
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                          new SizedBox(
                            width: 5,
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
            new SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

List<AppsItemBuilder> appsList = [
  new AppsItemBuilder(
    heroTag: "heroTag0",
    title: "Here's a sample of the E-Commerce App"
        " i built using flutter feel free to check it out",
    image: images1,
    price: 80.90,
    rating: 4.5,
  ),
  new AppsItemBuilder(
    heroTag: "heroTag1",
    title:
        "Here's a sample of Udemy App i built using flutter feel free to check it out",
    image: images2,
    price: 120.80,
    rating: 4.5,
  ),
  new AppsItemBuilder(
    heroTag: "heroTag2",
    title:
        "Here's a sample of Traveling App i built using flutter feel free to check it out",
    image: images3,
    price: 150.70,
    rating: 4.5,
  ),
  new AppsItemBuilder(
    heroTag: "heroTag3",
    title:
        "Here's a sample of Navigation App i built using flutter feel free to check it out",
    image: images4,
    price: 200.60,
    rating: 4.5,
  ),
];
