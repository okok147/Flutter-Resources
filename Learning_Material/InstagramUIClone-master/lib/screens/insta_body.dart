import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/instalist.dart';

class InstaBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: InstaList(),)
      ],
    );
  }
}
