import 'package:flutter/material.dart';

class HelloRectangle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(200.0),
        child: Container(
          color: Colors.lightBlueAccent,
          height: 400.0,
          width: 300.0,
          child:  Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(child: Text('HELLO',style: TextStyle(fontSize: 40.0))),
          ),


        ),
      ),

    );
  }
}



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HelloRectangle(),
      ),
    ),
  );
}
