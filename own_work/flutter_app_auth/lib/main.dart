import 'package:flutter/material.dart';

//TODO Import Pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      home: LoginPage(),

      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context)=> new SignupPage(),
        '/homepage' : (BuildContext context) => new HomePage()

      },

    );
  }
}