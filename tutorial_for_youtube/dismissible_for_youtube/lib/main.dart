import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
   
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
       body: Center(
         child: Dismissible(
           background: Container(
             
             color: Colors.redAccent,
             child: Icon(
               Icons.headset,
               size: 30,
               color: Colors.white,
    
             )
           ),

           secondaryBackground: Container(
             color: Colors.greenAccent,

           ),
           key: ValueKey('abc'),
           child: Container(
             child: Center(child: Text('Tutorial finished!HAHA,Happy Coding~')),
             height: 100,
             color: Colors.blueAccent,
           ),

         ),
       ),
    );
  }
}
