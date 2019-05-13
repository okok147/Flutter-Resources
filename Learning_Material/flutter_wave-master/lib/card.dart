import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CardItem extends StatelessWidget {
  final String title;
  final double maxWidth;
  final double height = 360;

  const CardItem({
    Key key,
    @required this.title,
    @required this.maxWidth,
  }) : super(key: key);

  final containerPadding = const EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 6),
          height: height,
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w600,
              color: Colors.grey[200],
            ),
          ),
        ),
        Positioned(
          top: 40,
          child: new _CardContainer(
            height: height - 50,
            maxWidth: maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: containerPadding,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: _CardHeader(title: this.title),
                      ),
                      Container(
                        height: 90,
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: <Widget>[
                            new _CardImage(assetName: 'pastel_1.jpeg'),
                            new _CardImage(assetName: 'pastel_2.jpeg'),
                            new _CardImage(isLast: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  padding: containerPadding,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 0.75),
                      bottom: BorderSide(color: Colors.grey[300], width: 0.75),
                    ),
                  ),
                  child: new _CardOffer(),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_circle,
                              size: 18,
                              color: Color.fromRGBO(80, 100, 240, 1),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Add to wishlist',
                              style: TextStyle(
                                color: Color.fromRGBO(80, 100, 240, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Ionicons.getIconData("ios-arrow-forward"),
                          size: 20.0,
                          color: Color.fromRGBO(80, 100, 240, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CardOffer extends StatelessWidget {
  const _CardOffer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Offer from Live nation',
          style: TextStyle(
            color: Color.fromRGBO(54, 55, 105, 1),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              color: Color.fromRGBO(240, 130, 126, 1),
            ),
          ),
          child: Text(
            '+50 dollars',
            style: TextStyle(
              color: Color.fromRGBO(240, 130, 126, 1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({
    Key key,
    @required this.height,
    @required this.maxWidth,
    @required this.child,
  }) : super(key: key);

  final double height;
  final double maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: maxWidth,
      margin: EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            offset: Offset(0.0, 5),
            blurRadius: 5.0,
          )
        ],
      ),
      child: this.child,
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String title;

  const _CardHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 12.0),
          padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(234, 235, 252, 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            children: <Widget>[
              Text(
                '29',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(80, 100, 240, 1),
                ),
              ),
              Text(
                'Jan',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(80, 100, 240, 1),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color.fromRGBO(54, 55, 105, 1),
                ),
              ),
              Text(
                'in 2 months',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(54, 55, 105, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  final bool isLast;
  final String assetName;

  _CardImage({
    Key key,
    this.isLast = false,
    this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: !isLast
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  'assets/$assetName',
                  fit: BoxFit.fill,
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purple[50],
                            Colors.pink[50],
                            Colors.grey[50],
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '23+',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(166, 150, 190, 1),
                          ),
                        ),
                        SizedBox(height: 1.5),
                        Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(166, 150, 190, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
