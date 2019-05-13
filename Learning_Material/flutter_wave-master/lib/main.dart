import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:wave/card.dart';
import 'package:wave/wave.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var events = ['Coachella', 'Havana'];

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Color.fromRGBO(54, 54, 97, 1),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            _WaveBg(marginTop: 50),
            Container(
              padding: EdgeInsets.only(top: 12, right: 24, left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Header(),
                  SizedBox(height: 65),
                  _Transactions(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 24),
                      child: new _EventList(events: events),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      iosContentPadding: false,
      iosContentBottomPadding: false,
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({
    Key key,
    @required this.events,
  }) : super(key: key);

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) => ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, ndx) {
              return new CardItem(
                title: events[ndx],
                maxWidth: size.maxWidth - 1.5,
              );
            },
          ),
    );
  }
}

class _Transactions extends StatelessWidget {
  const _Transactions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                FontAwesome.getIconData("dollar"),
                size: 16.0,
              ),
              SizedBox(width: 5),
              Text(
                '2 new transactions',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Icon(
            Ionicons.getIconData("ios-arrow-forward"),
            size: 18.0,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: Colors.grey[300]),
      ),
    );
  }
}

class _WaveBg extends StatelessWidget {
  final double marginTop;

  const _WaveBg({
    Key key,
    @required this.marginTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.2,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 50,
            color: Colors.grey,
            duration: Duration(seconds: 2, milliseconds: 800),
          ),
        ),
        Opacity(
          opacity: 0.3,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 100,
            color: Colors.grey,
            duration: Duration(seconds: 2, milliseconds: 200),
          ),
        ),
        WaveContainer(
          width: 200,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: marginTop),
          yOffset: 0,
          xOffset: 0,
          color: Colors.white,
          duration: Duration(seconds: 2, milliseconds: 900),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Home',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Welcome home, Sean',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          ],
        ),
        CircleAvatar(
          child: Text('S'),
        )
      ],
    );
  }
}
