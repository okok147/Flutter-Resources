import 'package:flutter/material.dart';
import 'package:list_with_data/colors.dart';

class AppConstants {
  static const appName = "Testing for data";
}

class AppTextStyles {
  static const headTextStyle = const TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
    color: CustomColors.headerTextColor,
  );

  static const subHeaderTextStyle = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  static const descriptionTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const unselectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static const selectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: CustomColors.primaryColor,
  );
}

class AvailableFonts {
  static const primaryFont = "Quicksand";
}
