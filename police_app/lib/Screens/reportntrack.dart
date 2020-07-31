import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/reportactive.dart';
import 'package:police_app/Screens/trackevidence.dart';
import 'package:police_app/constants.dart';

class ReportNTrack extends StatefulWidget {
  static String id = "/trackreport";
  @override
  _ReportNTrackState createState() => _ReportNTrackState();
}

class _ReportNTrackState extends State<ReportNTrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 70),
              child: ReusableCard(
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    ReportActive.id,
                  );
                },
                cardChild: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                        child: Container(
                          child: Image.asset(
                            "assets/images/report.gif",
                            height: 200,
                            width: 400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "REPORT an evidence",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
              child: ReusableCard(
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    TrackEvidence.id,
                  );
                },
                cardChild: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Container(
                          child: Image.asset(
                            "assets/images/track.gif",
                            height: 220,
                            width: 400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "TRACK an evidence",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
