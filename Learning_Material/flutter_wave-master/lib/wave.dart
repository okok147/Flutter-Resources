import 'package:flutter/material.dart';

import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

class WaveContainer extends StatelessWidget {
  final double height;
  final double width;
  final int xOffset;
  final int yOffset;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Duration duration;

  WaveContainer({
    @required this.height,
    @required this.width,
    @required this.xOffset,
    @required this.yOffset,
    @required this.color,
    this.duration,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Size size = new Size(MediaQuery.of(context).size.width, 200.0);

    return Wave(
      height: height,
      width: width,
      size: size,
      yOffset: yOffset,
      xOffset: xOffset,
      color: color,
      margin: margin,
      duration: duration,
    );
  }
}

class Wave extends StatefulWidget {
  final double height;
  final double width;
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Duration duration;

  Wave({
    @required this.height,
    @required this.width,
    @required this.size,
    @required this.xOffset,
    @required this.yOffset,
    @required this.color,
    this.margin,
    this.duration,
  });

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(seconds: 3),
    );

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        final dx = i.toDouble() + widget.xOffset;
        final dy = sin((animationController.value * 360 - i) %
                    360 *
                    Vector.degrees2Radians) *
                20 +
            50 +
            widget.yOffset;

        animList1.add(new Offset(dx, dy));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
              child: new Container(
                height: widget.height,
                color: widget.color,
              ),
              clipper: new WaveClipper(
                animationController.value,
                animList1,
              ),
            ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
