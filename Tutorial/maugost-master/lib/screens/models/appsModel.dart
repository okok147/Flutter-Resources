import 'package:flutter/material.dart';
import 'package:maugost/utils/images.dart';

class AppModel {
  String uid;
  String ownerId;
  String appCategory;
  String appTitle;
  String appDescription;
  String thumbnailURL;
  String videoURL;
  double appPrice;
  double appRating;
  List ratings;
  List views;
  List downloads;
  List reports;
  int createdAt;
  int updatedAt;
  bool isVisible;

  AppModel(
      {this.uid,
      this.ownerId,
      this.appCategory,
      this.appTitle,
      this.appDescription,
      this.thumbnailURL,
      this.videoURL,
      this.appPrice,
      this.appRating,
      this.ratings,
      this.views,
      this.downloads,
      this.reports,
      this.createdAt,
      this.updatedAt,
      this.isVisible});
}

List<AppModel> appsModelList = [
  new AppModel(
    appTitle: "Ecommerce App",
    appDescription: "Here's a sample of the E-Commerce App"
        " i built using flutter feel free to check it out",
    thumbnailURL: images1,
    appPrice: 80.90,
    appRating: 4.5,
  ),
  new AppModel(
    appTitle: "Udemy App",
    appDescription:
        "Here's a sample of Udemy App i built using flutter feel free to check it out",
    thumbnailURL: images2,
    appPrice: 120.80,
    appRating: 4.5,
  ),
  new AppModel(
    appTitle: "Traveling App",
    appDescription:
        "Here's a sample of Traveling App i built using flutter feel free to check it out",
    thumbnailURL: images3,
    appPrice: 150.70,
    appRating: 4.5,
  ),
  new AppModel(
    appTitle: "Uber Flutter",
    appDescription:
        "Here's a sample of Navigation App i built using flutter feel free to check it out",
    thumbnailURL: images4,
    appPrice: 200.60,
    appRating: 4.5,
  ),
];

List<AppModel> recentMerchants = [];
List<AppModel> emptyList = [];
