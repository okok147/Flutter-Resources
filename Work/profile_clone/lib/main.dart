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

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 50.0, right: 16.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Color(0xff080708),
                      size: 30.0,
                    ),
                    onPressed: () {},
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "Mockups",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25.0),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xff080708),
                      size: 30.0,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
