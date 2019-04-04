import 'package:flutter/material.dart';


void main() => runApp(Homepage());


class Homepage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
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



class _MyStatefulWidgetState extends State <MyStatefulWidget> {
  Widget build (BuildContext context) {
    return Scaffold (
      body: Center(
        child: Text('Homepage'),
      ),
    );
  }
}