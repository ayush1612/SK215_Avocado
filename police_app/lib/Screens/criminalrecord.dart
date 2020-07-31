import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'criminaldetail.dart';

class CriminalRecord extends StatefulWidget {
  static String id = "/criminals";
  @override
  _CriminalRecordState createState() => _CriminalRecordState();
}

class _CriminalRecordState extends State<CriminalRecord> {
  final _firestore = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final items = snapshot.data.documents;

    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Crime Record',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),

          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('CriminalRecord').snapshots(),
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
                              item["cid"],
//                              "CF" + number.toString() + 'M' + fin.toString(),
                              style: TextStyle(
                                color: Colors.cyanAccent,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Image.asset(
                              "assets/images/criminal.png",
                              height: 50.0,
                              width: 40,
                            ),
                            Text(
                              item["criminal"],
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Factory worker",
                              textAlign: TextAlign.center,
                            )
                          ],
                        ), onTap: () {
//                      Navigator.pushNamed(context, CriminalDetails.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CriminalDetails(
                              name: item['criminal'],
                              crime: item["crime"],
                            );
                          },
                        ),
                      );
                    }),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            item["crime"],
//                            criminalDetails[item]["status"].toString() ?? '',
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0),
                          ),
//                SizedBox(
//                  height: 15.0,
//                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/evidence3.png",
                                height: 50.0,
                                width: 70.0,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Image.asset(
                                "assets/images/evidence4.jpg",
                                height: 30.0,
                              )
                            ],
                          ),
//                SizedBox(
//                  height: 20.0,
//                ),
                          Text(
                            item["desc"],
//                            "Ms. Sunita was heading back from her office when Birju, Sarvesh and Guru raped her and murdered her",
                          )
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            item['case'] ?? '',
                            style: TextStyle(
                              color: Colors.yellowAccent,
                            ),
                          ),
//                SizedBox(
//                  height: 10.0,
//                ),
                          Text(
                            'Evidence:' + item["evidence"],
//                            "Evidences: 1.A knife with Sunita's blood.\n2.Postmortem report.",
                            style: kOrderText,
                          ),
                          Text("In-charge officer: " + item['officer'],
                              style: TextStyle(
                                color: Colors.cyanAccent,
                              ))
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
//                SizedBox(height: 20.0),
                          Image.asset("assets/images/court.jpeg", width: 70.0),
                          RaisedButton(
                            child: Text("Court Proceedings"),
                            onPressed: () => {
                              Navigator.pushNamed(context, CriminalDetails.id)
//                setState(() {
//                  udhaarDetails[item]['severity'] = 0;
//                });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
                criminalWidget.add(personWidget);
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
                          "CrimeID",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "ID of the criminal",
                      ),
                      DataColumn(
                        label: Text(
                          "Crime              ",
                          style: kOrderText,
//                      textAlign: TextAlign.start,
                        ),
                        numeric: true,
                        tooltip: "Crime List",
                      ),
                      DataColumn(
                        label: Text(
                          "Case",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "Name of Criminal",
                      ),
                      DataColumn(
                        label: Text(
                          "Court\nDetails",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "More Info",
                      ),
                    ],
                    rows: criminalWidget),
              );
            },
          ),

//        ],
//      ),
        ],
      ),
    );
  }
}
