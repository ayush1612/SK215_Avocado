//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/calendar.dart';
import 'package:police_app/Components/fir.dart';
import 'package:police_app/Components/police.dart';
import 'package:toggle_bar/toggle_bar.dart';

import '../constants.dart';

class Thana extends StatefulWidget {
  static String id = '/thana';
  @override
  _ThanaState createState() => _ThanaState();
}

class _ThanaState extends State<Thana> {
  List<String> labels = [" Virtual FIR", "Calendar", "Police"];

  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget currScreen(index) {
    if (index == 0) {
      FIR wid = new FIR();
      return wid.showFIR();
    } else if (index == 2) {
//      return Text('police');
      return Police().getPolice();
    } else {
      return CalendarOption().showCalendar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ToggleBar(
              labels: labels,
              backgroundColor: Colors.grey[800],
              onSelectionUpdated: (index) => setState(() => {
                    currentIndex = index,
                    print(index),
                  }),
            ),
            currScreen(currentIndex)
          ],
        ),
      ),
    );
  }
}
