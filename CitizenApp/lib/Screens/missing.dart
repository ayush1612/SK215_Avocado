import 'package:citizen_app/Model/missingIconContent.dart';
import 'package:citizen_app/Screens/reportMissing.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'missingList.dart';

class Missing extends StatelessWidget {
  static String id = 'missing';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
          title: Text(
            'Missing',
            style: kAppBarTextStyle,
          ),
          flexibleSpace: Container(
            decoration: kAppBarBoxDecoration,
          )),
      body: SafeArea(
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconContent(
                      icon: 'assets/img/missing.jpg',
                      label: 'Report',
                    ),
                  ),
                  onPress: () {
                    Navigator.pushNamed(context, Report.id);
                  },
                ),
                ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconContent(
                      icon: 'assets/img/missing3.png',
                      label: 'Found',
                    ),
                  ),
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DisplayLost()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
          child: cardChild,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
