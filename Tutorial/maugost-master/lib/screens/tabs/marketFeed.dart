import 'package:flutter/material.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';
import 'package:maugost/widgets/feedItemBuilder.dart';

class MarketTab extends StatefulWidget {
  @override
  _MarketTabState createState() => _MarketTabState();
}

class _MarketTabState extends State<MarketTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return buildAppsList();
  }

  buildAppsList() {
    return new ListView.builder(
        itemCount: appsList.length,
        padding: EdgeInsets.only(bottom: 80),
        itemBuilder: (context, index) {
          return new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AppDetail(
                              heroTag: "heroTagM$index",
                              data: appsList[index],
                            )));
              },
              child: Container(
                  //height: 130,
                  child:
                      new Hero(tag: "heroTagM$index", child: feedList[index])));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
