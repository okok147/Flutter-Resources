import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/screens/models/appsModel.dart';
import 'package:maugost/screens/payment/paymentDetails.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';

class CartTab extends StatefulWidget {
  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildAppsList(),
        buildSummary(),
        new SizedBox(height: 40)
      ],
    );
  }

  buildAppsList() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: 2,
          padding: EdgeInsets.only(left: 10, right: 10),
          itemBuilder: (context, index) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => AppDetail(
                                heroTag: "heroTagC$index",
                                data: appsList[index],
                              )));
                },
                child: Container(
                    height: 130,
                    child: new AppsItemBuilder(
                      title: appsModelList[index].appDescription,
                      image: appsModelList[index].thumbnailURL,
                      price: appsModelList[index].appPrice,
                      rating: appsModelList[index].appRating,
                    )));
          }),
    );
  }

  buildSummary() {
    return new Container(
      decoration: BoxDecoration(
          color: appRed,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 12),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new RichText(
            text: TextSpan(children: [
              new TextSpan(
                  text: "Total:",
                  style: TextStyle(color: Colors.white.withOpacity(0.7))),
              new TextSpan(
                  text: " \$201.7",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ]),
          ),
          new RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => PaymentDetails()));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.green,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 25),
              child: new Text(
                "Pay",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
