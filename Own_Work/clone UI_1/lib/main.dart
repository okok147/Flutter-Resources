
import 'package:flutter/material.dart';
import 'package:project/screens/onboard_widget.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      home: OnboardWidget(),
    );
  }
}