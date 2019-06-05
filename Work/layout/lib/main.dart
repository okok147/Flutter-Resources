import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(


  home: MyApp(),
  debugShowCheckedModeBanner: false,

));

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(
                
              ),
            )
          ],
        ),
      ),

    );
  }
}