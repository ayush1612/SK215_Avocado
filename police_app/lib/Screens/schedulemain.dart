import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/schedule.dart';

import '../constants.dart';

class ScheduleMain extends StatefulWidget {
  static String id = '/mainschedule';
  @override
  _ScheduleMainState createState() => _ScheduleMainState();
}

class _ScheduleMainState extends State<ScheduleMain> {
  bool week = false;
  Color bclr = Colors.blue;
  FlutterTts flutterTts = FlutterTts();
  static List<DataRow> listitems = [
    DataRow(
      cells: [
        DataCell(
          Text(
            "Monday",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "Mathikere",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "17:00-21:00",
            style: kItemsStyle,
          ),
        ),
      ],
    ),
    DataRow(
      cells: [
        DataCell(
          Text(
            "Tuesday",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "Chandni Chowk",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "9:00-13:00",
            style: kItemsStyle,
          ),
        ),
      ],
    ),
    DataRow(
      cells: [
        DataCell(
          Text(
            "Friday",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "Chandni Chowk",
            style: kItemsStyle,
          ),
        ),
        DataCell(
          Text(
            "15:00-18:00",
            style: kItemsStyle,
          ),
        ),
      ],
    ),
  ];
  ReusableCard month = ReusableCard();
  @override
  Future _speak(text) async {
//    print(await flutterTts.getLanguages);
//    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setVoice("hi-in-x-cfn-network");
    await flutterTts.setSpeechRate(0.47);
    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);

//    print(await flutterTts.getVoices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ReusableCard(
            onPress: () {
              print("Today's schedule");
              _speak(
                  "आपका आज का schedule yeh है. आपकी सुबह की ड्यूटी में शर्मा mansion robbery केस की जांच करना शामिल है. इसके बाद डीएम और एसपी के साथ मीटिंग है। शाम को आपको East Delhi zone में patrolling करनी है। Dhanyawad.");
            },
            colour: kActiveCardColor,
            cardChild: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/police.png",
                  width: 200,
                  height: 300,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: TyperAnimatedTextKit(
                          speed: Duration(milliseconds: 75),
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            "नमस्कार, त्रिपाठी जी",
//                        "नमस्कार, त्रिपाठी जी",
                          ],
                          textStyle: kOrderStyle
//                          TextStyle(fontSize: 10.0, fontFamily: "Bobbers"),
                          ),
                    ),
//                    Container(
//                      width: 150,
//                      height: 200,
//                      child: Text(
//                        "नमस्कार, त्रिपाठी जी",
//                        style: kOrderStyle,
//                      ),
//                    )
                    Text("Click to know today's schedule.")
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text("Weekly"),
                padding: EdgeInsets.all(25.0),
                onPressed: () {
                  print("Week");
                  setState(() {
                    week = !week;
                    if (week) {
                      bclr = Colors.cyan;
                      month = ReusableCard(
                        onPress: () {
                          print("Week Schedule");
                        },
                        colour: kActiveCardColor,
                        cardChild: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                ),
                                Text(
                                  "Current Week\nRegular Duty@Patrol\n",
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
//                            fontFamily: 'Pacifico',
                                    fontSize: 15.0,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                            DataTable(
                              dataRowHeight: 80.0,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "Day",
                                    style: kOrderText,
                                  ),
                                  numeric: false,
                                  tooltip: "Day",
                                ),
                                DataColumn(
                                  label: Text(
                                    "Location",
                                    style: kOrderText,
                                  ),
                                  numeric: false,
                                  tooltip: "Location",
                                ),
                                DataColumn(
                                  label: Text(
                                    "Schedule",
                                    style: kOrderText,
                                  ),
                                  numeric: false,
                                  tooltip: "Schedule",
                                ),
                              ],
                              rows: listitems,
                            ),
                          ],
                        ),
                      );
                    } else {
                      bclr = Colors.blue;
                      month = ReusableCard();
                    }
                  });
                },
                color: bclr,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text("Monthly"),
                padding: EdgeInsets.all(25.0),
                onPressed: () {
                  print("Month");
                  Navigator.pushNamed(context, MySchedule.id);
                },
                color: Colors.blue,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: month,
          )
        ],
      ),
    );
  }
}
