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
      backgroundColor: Color(0xffFAFAFA),
      // (0xffE8E8F3) for original colour

      body: Padding(
        padding:
            const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 8.0, top: 8.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Color(0xff080708),
                    size: 25.0,
                  ),
                  onPressed: () {},
                ),
                Spacer(),
                Text(
                  "Mockups",
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Color(0xff080708),
                    size: 20.0,
                  ),
                  onPressed: () {},
                )
              ],
            ),

            /*Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  top: 16.0,
                  child: Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: const Radius.circular(30.0)),
                    ),
                  ),
                ),
                Container(height: 200.0, child: Column()),
                Positioned(
                  top: 36.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('123'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('456'),
                      )
                    ],
                  ),
                ),
              ],
            ),*/

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                
                height: 300.0,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 10.0,
                            left: 0.0,
                            right: 0.0,
                            child: Card(

                              color: Colors.green,shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                              child: Container(
                                height: 200.0,
                              ),
                              
                              

                            ),


                          )
                        ],

                      )
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
