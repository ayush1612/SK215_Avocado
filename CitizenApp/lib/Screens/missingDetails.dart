import 'dart:ui';

import 'package:citizen_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class LostItem extends StatelessWidget {
  const LostItem({
    Key key,
    @required this.image,
    @required this.name,
    @required this.lastSeen,
    @required this.desc,
  }) : super(key: key);

  final image;
  final name;
  final lastSeen;
  final desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        title: Text('Missing Person'),
        flexibleSpace: Container(
          decoration: kAppBarBoxDecoration,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                '$name',
//            textAlign: TextAlign.center,
                style: kWidgetNormalText.copyWith(
                  color: Color(0xFFbbe1fa),
//                  fontStyle: FontStyle.italic
                ),
              ),
            ),
            Center(
              child: Image.file(
                File(image),
                height: 250,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 20),
              color: kActiveCardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Last Seen:\t$lastSeen',
                    style: kItemsStyle.copyWith(color: Color(0xFFbbe1fa)),
                  ),
                  Divider(
                    height: 35,
                  ),
                  Text(
                    'Description:\n$desc',
                    style: kItemsStyle.copyWith(color: Color(0xFFbbe1fa)),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
