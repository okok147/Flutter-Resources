
import 'package:flutter/material.dart';
import 'package:quiz_app_ui/screens/congrats_widget.dart';
import 'package:quiz_app_ui/screens/hello_widget.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: HelloWidget(),
    );
  }
}