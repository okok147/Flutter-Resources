import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/Homepage.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: new ThemeData(

        primarySwatch: Colors.green,
        primaryColor: Colors.white,
        canvasColor: Colors.white,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.black,
          onPressed: () {},
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 20.0,
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: new BottomNavigationBar(


          //how to change thee selected page with currentIndex in BottomNavigationBar
          currentIndex: _currentIndex,
          onTap: (value) {
            _currentIndex = value;
            setState(() {});
          },
          selectedItemColor: Colors.black,
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.person,color: Colors.blueAccent,),
              title: new Text('開聊',
              ),


            ),



            new BottomNavigationBarItem(
                icon: const Icon(Icons.settings,color: Colors.blueAccent,),
                title: new Text('設定')),
          ]),
    );
  }
}
