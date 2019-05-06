import 'package:flutter/material.dart';

class HelloRectangele extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.greenAccent,
        height: 400.0,
        width: 300.0,
        child: Center(
          child: Text('Hello',style: TextStyle(fontSize: 100.0),
          ),
        ),
      ),
    );
  }


}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('HAHA'),
      ),
      body: HelloRectangele(),
    ),
  ),
  );
}