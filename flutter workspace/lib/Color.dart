import 'package:flutter/material.dart';

class Cor {
  static const mainColor = Color(0xFFECB201);
  static const lightGrey = Color(0xFF8A8A8A);
  static const samllGrey = Color(0xFF5C5C5C);
  static const grey = Color(0xFF333333);
  static const deepGrey = Color(0xFF1F1F1F);
  static const darkColor = Color(0xFF111111);
  static const midGrey = Color(0xFF5C5C5C);
  static const black = Color(0xFF03263B);
  static const red = Color(0xFFD32E2E);
  static const Color palePink = Color(0xFFFF85D8);
  static const Color paleBlue = Color(0xFF3ABDDA);
  static const Color deppBlue = Color(0xFF032B42);
  static const Color paleGold = Color(0xFFE6D09F);
  static const Color grey2 = Color(0xFFD8D8D8);
  static const Color black2 = Color(0xFF16181E);
  static const Color grey3 = Color(0xFF828282);
  static const Color grey4 = Color(0xFF3D3D3D);

  static const Gradient bgColor = RadialGradient(radius: 1.5, colors: <Color>[
    Colors.white,
    Color(0xFFCCCCCC),
  ]);
  static const Gradient bgColor2 = LinearGradient(
    colors: <Color>[
      Color(0xFFF5F5F5),
      Color(0xFFCCCCCC),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

List<BoxShadow> commonShadow() => [
      BoxShadow(
          color: Color(0xFF4D4D4D), offset: Offset(0.0, 2.0), blurRadius: 4.0)
    ];
List<BoxShadow> commonShadow2() => [
      BoxShadow(
          color: Color(0xFF333333), offset: Offset(0.0, 2.0), blurRadius: 8.0)
    ];
