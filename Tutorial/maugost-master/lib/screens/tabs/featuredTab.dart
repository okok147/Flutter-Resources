import 'package:flutter/material.dart';
import 'package:maugost/screens/app/appCategories.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/screens/models/appsModel.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';
import 'package:maugost/widgets/categoryItemBuilder.dart';
import 'package:maugost/widgets/displayContainer.dart';

class FeaturedTab extends StatefulWidget {
  @override
  _FeaturedTabState createState() => _FeaturedTabState();
}

class _FeaturedTabState extends State<FeaturedTab>
    with AutomaticKeepAliveClientMixin {
  PageController _displayController = new PageController();
  int _currentDisplay = 0;

  onDisplayChange(int val) {
    setState(() {
      _currentDisplay = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.only(bottom: 60),
      children: <Widget>[buildDisplay(), buildCategories(), buildAppsList()],
    );
  }

  buildDisplay() {
    return Container(
      height: 180,
      //margin: EdgeInsets.all(15),
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new PageView.builder(
              controller: _displayController,
              onPageChanged: onDisplayChange,
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                return displayList[index];
              }),
          _buildIndicator(list: displayList.length, position: _currentDisplay)
        ],
      ),
    );
  }

  buildCategories() {
    return Container(
      height: 130,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "Categories",
                  style: TextStyle(fontSize: 16),
                ),
                new Text(
                  "See all",
                  style: TextStyle(color: appRed, fontSize: 16),
                ),
              ],
            ),
          ),
          new Flexible(
            child: new ListView.builder(
                itemCount: categoryList.length,
                padding: EdgeInsets.only(left: 15, right: 15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => AppCategories(
                                      appCategory: "Shopping",
                                    )));
                      },
                      child: categoryList[index]);
                }),
          )
        ],
      ),
    );
  }

  _buildIndicator({int list, int position}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: indicatorChildren(list: list, position: position),
      ),
    );
  }

  List<Widget> indicatorChildren({int list, int position}) {
    return new List<Widget>.generate(list, (int index) {
      if (index == position) {
        return Container(
          height: 8,
          width: 8,
          margin: EdgeInsets.all(5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        );
      }

      return Container(
        height: 8,
        width: 8,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
      );
    });
  }

//  buildAppsList() {
//    return new ListView.builder(
//        itemCount: 5,
//        physics: NeverScrollableScrollPhysics(),
//        shrinkWrap: true,
//        padding: EdgeInsets.only(left: 15, right: 15),
//        itemBuilder: (context, index) {
//          return buildItems();
//        });
//  }

  buildAppsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Text(
            "Top Trending",
            style: TextStyle(fontSize: 16),
          ),
        ),
        new ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 60),
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
      ],
    );
  }

  buildItems() {
    return Container(
      height: 180,
      child: Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  "Categories",
                  style: TextStyle(fontSize: 16),
                ),
                new Text(
                  "See all",
                  style: TextStyle(color: appRed, fontSize: 16),
                ),
              ],
            ),
          ),
          new Flexible(
            child: Container(
              height: 150,
              child: new PageView.builder(
                  controller: new PageController(viewportFraction: 0.85),
                  itemCount: appsList.length,
                  itemBuilder: (context, index) {
                    return new GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => AppDetail(
                                        heroTag:
                                            "heroTagM$index${new DateTime.now().toIso8601String()}",
                                        data: appsList[index],
                                      )));
                        },
                        child: Container(
                            height: 150,
                            child: new Hero(
                                tag:
                                    "heroTagM$index${new DateTime.now().toIso8601String()}",
                                child: appsList[index])));
                  }),
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
