import 'package:flutter/material.dart';
import 'package:maugost/utils/images.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            maxRadius: 25,
            backgroundImage: AssetImage(myPics),
          ),
          new SizedBox(
            width: 10,
          ),
          new Flexible(
              child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (v) {},
                    starCount: 5,
                    rating: 4.5,
                    size: 20.0,
                    color: Colors.green,
                    borderColor: Colors.green,
                  ),
                  new SizedBox(
                    width: 10,
                  ),
                  new Text("20 March 2019")
                ],
              ),
              new SizedBox(
                height: 10,
              ),
              new Text(
                "The App i purchased is worth it, "
                    "i love your designs, the are slick and superB, keep it up bro.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(0.6)),
              )
            ],
          ))
        ],
      ),
    );
  }
}
