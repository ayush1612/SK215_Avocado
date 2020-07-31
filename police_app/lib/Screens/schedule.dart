import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:police_app/Components/reusablecard.dart';

import '../constants.dart';

class MySchedule extends StatefulWidget {
  static String id = "/schedule";
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
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

  @override
  Widget build(BuildContext context) {
    Future _speak(text) async {
//      print(await flutterTts.getLanguages);
//      await flutterTts.setLanguage("hi-IN");
      await flutterTts.setVoice("hi-in-x-cfn-network");
      await flutterTts.setSpeechRate(0.47);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }

    List<ReusableCard> routineWidget = [
      ReusableCard(
        cardChild: SizedBox(
          height: 15.0,
        ),
      ),
      ReusableCard(
        onPress: () {
          _speak(
              "namaskar, त्रिपाठी जी। सोमवार को आपकी ड्यूटी शाम 5 बजे से 9 बजे तक मथिकेरे में है। मंगलवार को आपकी ड्यूटी सुबह 9 बजे से दोपहर 1 बजे तक चांदनी चौक में है। शुक्रवार को आपकी ड्यूटी दोपहर 3 से 6 बजे तक फिर से चांदनी चौक में है।");
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
                  "February: Week 1\n\nRegular Duty@Patrol\n",
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
      ),
      ReusableCard(
        cardChild: SizedBox(
          height: 25.0,
        ),
      ),
      ReusableCard(
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
                  "February: Week 2\n\nRegular Duty@Patrol\n",
                  style: TextStyle(
                    color: Colors.cyanAccent,
//                            fontFamily: 'Pacifico',
                    fontSize: 15,
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
      ),
      ReusableCard(
        cardChild: SizedBox(
          height: 25.0,
        ),
      ),
      ReusableCard(
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
                  "February: Week 3\n\nRegular Duty@Patrol\n",
                  style: TextStyle(
                    color: Colors.cyanAccent,
//                            fontFamily: 'Pacifico',
                    fontSize: 15,
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
      ),
    ];
    return Scaffold(
        appBar: kAppBar,
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                'My Schedule',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView(
//                padding: EdgeInsets.all(0.0),
                children: routineWidget,
              ),
            ),
          ],
        ));
  }
}
