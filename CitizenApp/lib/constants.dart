import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kWidgetNormalText = TextStyle(
  fontSize: 20,
  letterSpacing: 1.8,
);

const kHeadingText =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 30, letterSpacing: 1.8);

const kActiveCardColor = Color(0xFF1D1E33);

const kItemsStyle = TextStyle(
  fontSize: 16,
);

const kBackgroundColour = Color(0xFF111328);

const kAppBarTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 36.0);

const kAppBarBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
      colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp),
);

const kTextBoxDecoration = InputDecoration(
//  border: OutlineInputBorder(),
  hintStyle: TextStyle(color: Colors.grey),
);
