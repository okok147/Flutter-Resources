import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maugost/main.dart';
import 'package:maugost/screens/app/appDetail.dart';
import 'package:maugost/screens/app/appSearch.dart';
import 'package:maugost/screens/models/appsModel.dart';
import 'package:maugost/screens/post/postApp.dart';
import 'package:maugost/screens/tabs/cartTab.dart';
import 'package:maugost/screens/tabs/featuredTab.dart';
import 'package:maugost/screens/tabs/marketFeed.dart';
import 'package:maugost/screens/tabs/profileTab.dart';
import 'package:maugost/utils/colors.dart';
import 'package:maugost/utils/images.dart';
import 'package:maugost/widgets/appsItemBuilder.dart';
import 'package:maugost/widgets/bottomTabs.dart';
import 'package:maugost/widgets/myAppBar.dart';
import 'package:maugost/widgets/notFoundWidget.dart';
import 'package:maugost/widgets/tabsBuilder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = new PageController(
    keepPage: true,
  );
  ValueNotifier<bool> bubbleNotifier = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: appBG,
      appBar: MyAppBar(
        pageController: _pageController,
      ),
      body: scaffoldBody(),
      //bottomNavigationBar: bottomNavigationBar(),
    );
  }

  scaffoldBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new PageView(
          controller: _pageController,
          //onPageChanged: onPageChange,
          children: <Widget>[
            new FeaturedTab(),
            new MarketTab(),
            new CartTab(),
            new ProfileTab(),
          ],
        ),
        RevealFloatingBubble(
          bubbleNotifier: bubbleNotifier,
        ),
        BottomTabs(
          pageController: _pageController,
          bubbleNotifier: bubbleNotifier,
        )
      ],
    );
  }
}

class RevealFloatingBubble extends StatefulWidget {
  final ValueNotifier<bool> bubbleNotifier;

  const RevealFloatingBubble({Key key, this.bubbleNotifier}) : super(key: key);
  @override
  RevealFloatingBubbleState createState() => RevealFloatingBubbleState();
}

class RevealFloatingBubbleState extends State<RevealFloatingBubble>
    with SingleTickerProviderStateMixin {
  AnimationController bubbleController;
  double textSize = 14.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bubbleController = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    widget.bubbleNotifier.addListener(bubbleListener);
    //bubbleListener();
  }

  bubbleListener() {
    print(widget.bubbleNotifier.value);
    if (widget.bubbleNotifier.value == true) {
      bubbleController.reset();
      bubbleController.animateTo(0.1);
      return;
    }
    bubbleController.reset();
    bubbleController.animateBack(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        return Transform.scale(
          scale: bubbleController.value * 10,
          alignment: Alignment.bottomCenter,
          child: new GestureDetector(
            onTap: () {
              widget.bubbleNotifier.value = false;
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              child: new Container(
                height: 250,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 80),
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120),
                    )),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        widget.bubbleNotifier.value = false;
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PostApp()));
                      },
                      child: new Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: new Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 120 * bubbleController.value),
                          )),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        decoration: new BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: new Text(
                          "Project",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 120 * bubbleController.value),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      animation: bubbleController,
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
