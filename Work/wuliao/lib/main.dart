import 'package:flutter/material.dart';
import 'package:testing/Homepage.dart';
import 'package:testing/Search.dart';

void main() {

  runApp(new MyApp(


  ));

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generated App',
      theme: new ThemeData(

        brightness:Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF64ffda),
        canvasColor: const Color(0xFF303030),
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
  Widget callPage(int currentIndex){

    switch(currentIndex){
      case 0: return HomePage();
      case 1: return SearchPage();




    }



  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        title: Center(child: new Text('無聊吧')),
      ),
      body:
      callPage(_currentIndex),

      bottomNavigationBar: new BottomNavigationBar(
        elevation: 15.0,

        //how to change thee selected page with currentIndex in BottomNavigationBar
        currentIndex: _currentIndex,
        onTap: (value) {

          _currentIndex = value;
          setState(() {

          });
        },

        selectedItemColor: Color(0xFF64ffda),
          items: [
            new BottomNavigationBarItem(
              icon: const Icon(Icons.people),
              title: new Text('開聊'),

            ),

            new BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              title: new Text('搜尋'),
            ),
            new BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              title: new Text('最愛')
            ),
          ]

      ),
    );
  }
}