import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram Clone",
      theme: ThemeData(
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.black),
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white,fontFamily: 'Aveny')),
        textTheme: TextTheme(title: TextStyle(color: Colors.black)),
      ),
      home: InstaHome(),
    );
  }
}