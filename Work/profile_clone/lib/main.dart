import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.white),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // (0xffE8E8F3) for original colour

      body: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Color(0xff080708),
                    size: 30.0,
                  ),
                  onPressed: () {},
                ),
                Spacer(),
                Text(
                  "Mockups",
                  style: new TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color(0xff080708),
                    size: 30.0,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Container(

              child: ,
            ),
          ],
        ),
      ),
    );
  }
}
