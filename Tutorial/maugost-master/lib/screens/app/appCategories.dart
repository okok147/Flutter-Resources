import 'package:flutter/material.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';

class AppCategories extends StatefulWidget {
  final String appCategory;

  const AppCategories({Key key, this.appCategory}) : super(key: key);
  @override
  _AppCategoriesState createState() => _AppCategoriesState();
}

class _AppCategoriesState extends State<AppCategories>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("${widget.appCategory}"),
      ),
      body: buildAppsList(),
    );
  }

  buildAppsList() {
    return new ListView.builder(
        itemCount: appsList.length,
        padding: EdgeInsets.all(5),
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
                  height: 130,
                  child:
                      new Hero(tag: "heroTagM$index", child: appsList[index])));
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
