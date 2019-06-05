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
      title: '無聊吧',
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        accentColor: Colors.black,
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
        bottomOpacity: 0.7,
        leading: IconButton(
          icon: Icon(Icons.whatshot),
          color: Colors.redAccent,
          onPressed: () {},
        ),
        title: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text('無聊吧', textAlign: TextAlign.center)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.green,
              ),
              onPressed: ,
            ),
          ),
        ],
      ),
      body: callPage(_currentIndex),
      bottomNavigationBar: new BottomNavigationBar(
          elevation: 10.0,

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
