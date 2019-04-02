import 'package:flutter/material.dart';
import 'package:pin_code_view/pin_code_view.dart';

class PinScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isOTP;

  const PinScreen({Key key, this.title, this.subTitle, @required this.isOTP})
      : super(key: key);

  Widget build(BuildContext context) {
    return PinCode(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
      subTitle: Text(
        subTitle,
        style: TextStyle(color: Colors.white),
      ),
      codeLength: isOTP == true ? 5 : 4,
      obscurePin: true,
      onCodeEntered: (code) {
        Navigator.pop(context, code);
      },
    );
  }
}
