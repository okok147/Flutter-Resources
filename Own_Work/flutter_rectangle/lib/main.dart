import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '???',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Hello AppBar'),
      ),
      body: HelloRectangle(),
    ),

  ));

}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center (

      child:Container(
      color: Colors.greenAccent,
      height: 400.0,
      width: 300.0,





      child: Center(
        child: Text(
          'YO',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 100.0,fontFamily: 'Montserrat'),

        ),


      ),


    ),

    );
  }
}