import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MyCases extends StatefulWidget {
  static String id = "/mycases";

  @override
  _MyCasesState createState() => _MyCasesState();
}

class _MyCasesState extends State<MyCases> {
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
            stream: _firestore.collection('ActiveCases').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                  ),
                );
              }
              final items = snapshot.data.documents;
              List<DataRow> criminalWidget = [];

              for (var item in items) {
                final personWidget = DataRow(
                  cells: [
                    DataCell(
                        Column(
                          children: <Widget>[
                            Text(
                              item['cid'],
                              style: TextStyle(
                                color: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                              "assets/images/policebadge.png",
                              height: 50.0,
                              width: 40,
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
                            item['crime'],
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0),
                          ),
//                SizedBox(
//                  height: 15.0,
//                ),
                          Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/police2.png",
                                height: 70.0,
                                width: 60.0,
                              ),
                              Text(
                                "Assisting officer:\n " + item['officer'],
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                ),
                              )
                            ],
                          ),
//                SizedBox(
//                  height: 20.0,
//                ),
                          Text(
                            item['desc'],
//                              "Ms. Sunita was heading back from her office when Birju, Sarvesh and Guru raped her and murdered her")
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
//                          Text(
//                            "65%",
//                            style: TextStyle(color: Colors.greenAccent),
//                          ),
//                SizedBox(height: 20.0),
//                Image.asset("assets/images/progress.gif", width: 70.0),
                          Image.asset(
                            "assets/images/knife.png",
                            width: 50,
                            height: 50,
                          ),
                          Image.asset(
                            "assets/images/fingerprint.gif",
                            width: 60,
                            height: 60,
                          )
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            item['laws'],
                            style: TextStyle(
                              color: Colors.yellowAccent,
                            ),
                          ),
//                SizedBox(
//                  height: 10.0,
//                ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Next Hearing:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  item['hearing'],
                                  style: TextStyle(
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                          "Crime\/\nAssisting Officer              ",
                          style: kOrderText,
//                      textAlign: TextAlign.start,
                        ),
                        numeric: true,
                        tooltip: "Crime List",
                      ),
                      DataColumn(
                        label: Text(
                          "Progress\/\nEvidences",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "More Info",
                      ),
                      DataColumn(
                        label: Text(
                          "Laws/\nHearings",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "Laws",
                      ),
                    ],
                    rows: criminalWidget),
              );
            },
          )

//        ],
//      ),
        ],
      ),
    );
  }
}
