import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maugost/screens/homePage.dart';
import 'package:ravepay/ravepay.dart';

void main() {
  Rave.init(
      production: false,
      publicKey: "FLWPUBK-9768585b355bc716fd3343688a0df49b-X",
      secretKey: "FLWSECK-fd4172f2b7fc2935adbf67e8e60d6dbc-X");

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: appColor, // navigation bar color
    statusBarColor: appColor, // status bar color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maugost',
      theme: ThemeData(
          primarySwatch: appColor, fontFamily: "assets/fonts/GOTHIC.TTF"),
      home: HomePage(),
    );
  }
}

const MaterialColor appColor = MaterialColor(
  _redPrimaryValue,
  <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(_redPrimaryValue),
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFFC62828),
    900: Color(0xFFB71C1C),
  },
);
const int _redPrimaryValue = 0xFFb83a3a;
