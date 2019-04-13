import 'package:flutter/material.dart';

void main() => runApp(Profile());

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Homepage',
      darkTheme: ThemeData.dark(

      ),
      home: MyStatefulWidget(),
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget ({Key key}) : super (key:key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      body: Center (
        child: Text('Profile'),
      ),
    );
  }
}

