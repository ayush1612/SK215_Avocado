import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:police_app/Components/icon.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/news.dart';
import 'package:police_app/Screens/profile.dart';
import 'package:police_app/Screens/thana.dart';

import '../constants.dart';

class Others extends StatefulWidget {
  static String id = '/others';
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  String _openResult = 'Unknown';

  Future<void> openFile() async {
    final filePath = '/storage/emulated/0/Download/coi_part_full.pdf';
    final result = await OpenFile.open(filePath);

    setState(() {
      _openResult = "type=${result.type}  message=${result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableCard(
                onPress: () {
                  Navigator.pushNamed(context, News.id);
                },
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 180,
                    width: 170,
                    child: IconContent(
                      icon: FontAwesomeIcons.newspaper,
                      label: 'News',
                    ),
                  ),
                ),
              ),
              ReusableCard(
                onPress: () {
                  Navigator.pushNamed(context, Profile.id);
                },
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 180,
                    width: 170,
                    child: IconContent(
                      icon: FontAwesomeIcons.userAlt,
                      label: 'Profile',
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableCard(
                onPress: openFile
//              () {
//                  Navigator.pushNamed(context, Constitution.id);
//                }
                ,
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 180,
                    width: 170,
                    child: IconContent(
                      icon: FontAwesomeIcons.book,
                      label: 'Constitution',
                    ),
                  ),
                ),
              ),
              ReusableCard(
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 180,
                    width: 170,
                    child: IconContent(
                      icon: FontAwesomeIcons.connectdevelop,
                      label: 'D.A.R',
                    ),
                  ),
                ),
              )
            ],
          ),
          ReusableCard(
            onPress: () {
              Navigator.pushNamed(context, Thana.id);
            },
            colour: kActiveCardColor,
            cardChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: IconContent(
                  icon: FontAwesomeIcons.warehouse,
                  label: 'My Thana',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
