import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  //Color of background with gradient change
  static const Color loginGradientStart = const Color(0xFFf3f0ef);
  static const Color loginGradientEnd = const Color(0xFF7d42fef   );

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
  );
}