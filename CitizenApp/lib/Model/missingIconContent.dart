import 'package:flutter/material.dart';

import '../constants.dart';

class IconContent extends StatelessWidget {
  IconContent({this.icon, this.label});

  final String icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          icon,
          height: 140,
          width: 140,
        ),
        Text(
          label,
          style: kHeadingText,
        ),
      ],
    );
  }
}
