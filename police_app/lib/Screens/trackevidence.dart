import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'evidences.dart';

class TrackEvidence extends StatefulWidget {
  static String id = "/trackevidence";
  @override
  _TrackEvidenceState createState() => _TrackEvidenceState();
}

class _TrackEvidenceState extends State<TrackEvidence> {
  final _firestore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'My Active Cases',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("ActiveCases").snapshots(),
            builder: (context, snapshot) {
              List<DataRow> criminalWidget = [];
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                  ),
                );
              }
              final items = snapshot.data.documents;

              for (var item in items) {
                final personWidget = DataRow(
                  cells: [
                    DataCell(
                        Column(
                          children: <Widget>[
                            Text(
                              item['cid'] != null ? item['cid'] : ' ',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                              "assets/images/policebadge.png",
                              height: 40.0,
                              width: 30,
                            ),
                            Text(
                              "Complex",
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "12/12/2019",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ), onTap: () {
//                      Navigator.pushNamed(context, CriminalDetails.id);
                    }),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            item['crime'] != null ? item['crime'] : ' ',
                            style: TextStyle(
                                letterSpacing: 1.25,
                                color: Colors.amberAccent,
                                fontStyle: FontStyle.italic,
                                fontSize: 16.0),
                          ),
                          Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/police2.png",
                                height: 60.0,
                                width: 50.0,
                              ),
                              Text(
                                  "Assisting officer:\n" + item['officer'] !=
                                          null
                                      ? item['officer']
                                      : ' ',
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                  ))
                            ],
                          ),
                          Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/police2.png",
                                height: 60.0,
                                width: 50.0,
                              ),
                              Text("Pratik Rawal",
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        children: <Widget>[
                          OutlineButton(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(13, 10, 13, 10),
                              child: Text("Evidences"),
                            ),
                            borderSide: BorderSide(
                              color: Colors.cyanAccent,
                              width: 3.0,
                            ),
                            onPressed: () {
//                                Navigator.pushNamed(context, Evidences.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Evidences(
                                      allevidences: item['allevidences'],
                                    );
                                  },
                                ),
                              );
//                              print(item['allevidences'].toString() + '\n');
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                );
                criminalWidget.add(personWidget);
//      }
              }

              return Expanded(
                child: DataTable(
                    dataRowHeight: 200.0,
                    columnSpacing: 15,
                    headingRowHeight: 70,
                    horizontalMargin: 0.0,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Case ID",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "ID of the case",
                      ),
                      DataColumn(
                        label: Text(
                          "Assisting Officers              ",
                          style: kOrderText,
//                      textAlign: TextAlign.start,
                        ),
                        numeric: true,
                        tooltip: "Officers",
                      ),
                      DataColumn(
                        label: Text(
                          "Evidences",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "More Info",
                      ),
                    ],
                    rows: criminalWidget),
              );
            },
          )
        ],
      ),
    );
  }
}
