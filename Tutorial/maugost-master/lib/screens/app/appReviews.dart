import 'package:flutter/material.dart';
import 'package:maugost/widgets/reviewBuilder.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AppReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("App Reviews"),
      ),
      body: scaffoldBody(),
    );
  }

  scaffoldBody() {
    return new ListView(
      children: <Widget>[
        buildAppReviews(),
      ],
    );
  }

  buildAppReviews() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.1))),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          new SizedBox(
            height: 10,
          ),
          new Row(
            children: <Widget>[
              new SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (v) {},
                starCount: 5,
                rating: 4.5,
                size: 25.0,
                color: Colors.green,
                borderColor: Colors.green,
              ),
              new SizedBox(
                width: 10,
              ),
              new Text("8 Reviews")
            ],
          ),
          new SizedBox(
            height: 10,
          ),
          new Divider(),
          new ListView.separated(
            itemCount: 8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ReviewBuilder();
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Divider();
            },
          )
        ],
      ),
    );
  }
}
