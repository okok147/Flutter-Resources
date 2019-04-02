import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/screens/homePage.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class FeedItemBuilder extends StatelessWidget {
  final String heroTag;
  final String title;
  final String image;
  final double price;
  final double rating;
  final Color textColor;
  final Color ratingColor;
  final Function onClicked;

  const FeedItemBuilder(
      {Key key,
      this.title,
      this.textColor = Colors.black87,
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
        padding: EdgeInsets.only(top: 15, bottom: 15),
        margin: EdgeInsets.only(
          top: 15,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(0.1)),
              bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
            )),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(myPics), fit: BoxFit.cover)),
                      ),
                      new SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "Maugost Mtellect",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new SizedBox(
                            height: 2,
                          ),
                          new Text(
                            "Just now. Silicon Valley",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                    ],
                  ),
                  new Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: new Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 15),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Center(
                child: new Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle),
                    child: Center(
                        child: new Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ))),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    alignment: Alignment.center),
                color: Colors.white,
              ),
            ),
            new Container(
              height: 40,
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Center(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.star,
                          color: Colors.orange[600],
                          //size: 25,
                        ),
                        new SizedBox(
                          width: 5,
                        ),
                        new Text(
                          "4.5k",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(
                          OMIcons.cloudDownload,
                          color: Colors.grey.withOpacity(0.5),
                          //size: 25,
                        ),
                        new SizedBox(
                          width: 5,
                        ),
                        new Text(
                          "2.5k",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(
                          OMIcons.forum,
                          color: Colors.grey.withOpacity(0.5),
                          //size: 25,
                        ),
                        new SizedBox(
                          width: 5,
                        ),
                        new Text(
                          "4.5k",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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

List<FeedItemBuilder> feedList = [
  new FeedItemBuilder(
    heroTag: "heroTag0",
    title: "Here's a sample of the E-Commerce App"
        " i built using flutter feel free to check it out",
    image: images1,
    price: 80.90,
    rating: 4.5,
  ),
  new FeedItemBuilder(
    heroTag: "heroTag1",
    title:
        "Here's a sample of Udemy App i built using flutter feel free to check it out",
    image: images2,
    price: 120.80,
    rating: 4.5,
  ),
  new FeedItemBuilder(
    heroTag: "heroTag2",
    title:
        "Here's a sample of Traveling App i built using flutter feel free to check it out",
    image: images3,
    price: 150.70,
    rating: 4.5,
  ),
  new FeedItemBuilder(
    heroTag: "heroTag3",
    title:
        "Here's a sample of Navigation App i built using flutter feel free to check it out",
    image: images4,
    price: 200.60,
    rating: 4.5,
  ),
];
