import 'package:flutter/material.dart';

void main() => runApp(WorkPage());



class WorkPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Code Sample for material.Scaffold',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();


}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;


  Widget build(BuildContext context) {

    return Scaffold(


      body: Center(
        child: Text('Cyun.'),
      ),



    );
  }
}