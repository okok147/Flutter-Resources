import 'package:flutter/material.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/screens/models/appsModel.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';
import 'package:maugost/widgets/notFoundWidget.dart';

class AppSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    Map<int, AppModel> result = appsModelList
        .where((p) => p.appDescription.contains(query))
        .toList()
        .asMap();

    final resultList = query.isEmpty
        ? emptyList
        : appsModelList.where((p) => p.appDescription.contains(query)).toList();

    return resultList.isEmpty
        ? new Container()
        : new AppsItemBuilder(
            title: resultList[0].appDescription,
            image: resultList[0].thumbnailURL,
            price: resultList[0].appPrice,
            rating: resultList[0].appRating,
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final suggestionList = query.isEmpty
        ? recentMerchants
        : appsModelList
            .where((p) =>
                p.appDescription.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return suggestionList.isEmpty
        ? NotFoundWidget(
            notFoundIcon: Icons.search,
            notFoundTitle: "Epmty Search",
            notFoundSubTitle: "~Search for an App built with flutter~",
          )
        : ListView.builder(
            itemCount: suggestionList.length,
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
                    title: suggestionList[index].appDescription,
                    image: suggestionList[index].thumbnailURL,
                    price: suggestionList[index].appPrice,
                    rating: suggestionList[index].appRating,
                  ),
                ),
              );
            });
  }
}
