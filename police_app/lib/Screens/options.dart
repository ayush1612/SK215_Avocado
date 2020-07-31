import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:police_app/Components/icon.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/criminalrecord.dart';
import 'package:police_app/Screens/mycases.dart';
import 'package:police_app/Screens/reportntrack.dart';
import 'package:police_app/Screens/schedulemain.dart';

import '../constants.dart';
import 'AlertMain.dart';
import 'mostwanted.dart';
import 'others.dart';

class Options extends StatefulWidget {
  static String id = '/options';
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                    cardChild: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IconContent(
                        icon: FontAwesomeIcons.receipt,
                        label: 'Crime Records',
                      ),
                    ),
                    onPress: () {
                      Navigator.pushNamed(
                        context,
                        CriminalRecord.id,
                      );
                    },
                    colour: kActiveCardColor),
              ),
              Expanded(
                child: ReusableCard(
                  cardChild: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconContent(
                      icon: FontAwesomeIcons.cameraRetro,
                      label: 'Evidence Reporter\n and Tracker',
                    ),
                  ),
                  colour: kActiveCardColor,
                  onPress: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),
                            pageBuilder: (_, __, ___) => ReportNTrack()));
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: ReusableCard(
              cardChild: Padding(
                padding: const EdgeInsets.fromLTRB(160, 15, 160, 15),
//                padding: const EdgeInsets.all(15.0),

                child: IconContent(
                  icon: FontAwesomeIcons.bomb,
                  label: 'Most Wanted',
                ),
              ),
              onPress: () {
                Navigator.pushNamed(
                  context,
//                  MapActive.id,
                  MostWanted.id,
                );
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) {
//                      return MapActive(
//                        p: Position(latitude: 20.0, longitude: 79.0),
//                      );
//                    },
//                  ),
//                );
              },
              colour: kActiveCardColor,
            ),
          ),
          Row(
            children: <Widget>[
              ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 30, 60, 30),
                    child: IconContent(
                      icon: FontAwesomeIcons.photoVideo,
                      label: 'My Cases',
                    ),
                  ),
                  onPress: () {
                    Navigator.pushNamed(
                      context,
                      MyCases.id,
                    );
                  }

//                  colour: kActiveCardColor,

                  ),
//              SizedBox(
//                width: 10,
//              ),
              ReusableCard(
                cardChild: Padding(
                  padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                  child: IconContent(
                    icon: FontAwesomeIcons.microphoneAlt,
                    label: 'Alert',
                  ),
                ),
                onPress: () {
                  Navigator.pushNamed(context, AlertMain.id);
                },
                colour: kActiveCardColor,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ReusableCard(
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 40, 50, 40),
                  child: IconContent(
                    icon: FontAwesomeIcons.tools,
                    label: 'Others',
                  ),
                ),
                onPress: () {
                  Navigator.pushNamed(context, Others.id);
                },
              ),
              ReusableCard(
                cardChild: Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 40, 55, 40),
                  child: IconContent(
                    icon: FontAwesomeIcons.calendarAlt,
                    label: 'My Schedule',
                  ),
                ),
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    ScheduleMain.id,
                  );
                },
                colour: kActiveCardColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
