import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:police_app/Screens/crimereporter.dart';
import 'package:police_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportActive extends StatefulWidget {
  static String id = '/reportactive';
  @override
  _ReportActiveState createState() => _ReportActiveState();
}

class _ReportActiveState extends State<ReportActive> {
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
              List<DataRow> criminalWidget = [];
              final items = snapshot.data.documents;
              for (var item in items) {
                _launchURL() async {
                  if (await canLaunch("https://sbis04.github.io/demo360/")) {
                    await launch("https://sbis04.github.io/demo360/");
                  } else {
                    throw 'Could not launch';
                  }
                }

                final personWidget = DataRow(
                  cells: [
                    DataCell(
                        Column(
                          children: <Widget>[
                            Text(
                              item["cid"] != null ? item['cid'] : ' ',
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
                                "assets/images/knife.png",
//                                    ' ',
                                height: 90.0,
                                width: 140.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Assisting officer:\n" + item['officer'],
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                  ))
                            ],
                          ),
//                SizedBox(
//                  height: 20.0,
//                ),
                          Text(
                            item['desc'],
                          )
                        ],
                      ),
                    ),
                    DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            child: Text("Add evidence"),
                            onPressed: () {
                              print(item.documentID);
//                  debugPrint("Working");
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
//                            titlePadding: EdgeInsets.all(10.0),
                                      backgroundColor: Colors.white,
                                      content: new SingleChildScrollView(
                                        child: new ListBody(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: GestureDetector(
                                                child: new Text(
                                                  'Take a picture',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  var picture =
                                                      await ImagePicker
                                                          .pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  Directory appDocDir =
                                                      await getApplicationDocumentsDirectory();
                                                  String bgPath = appDocDir.uri
                                                      .resolve("background" +
                                                          Random()
                                                              .nextInt(1000)
                                                              .toString() +
                                                          ".jpg")
                                                      .path;
                                                  File bgFile = await picture
                                                      .copy(bgPath);
//                                                  File bgFile =
//                                                      File(appDocDir.path);
                                                  debugPrint(bgFile.path);
//                                        Navigator.pushNamed(
//                                            context, CrimeReporter.id);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return CrimeReporter(
                                                      bgFile: bgFile,
                                                      docid: item.documentID,
                                                    );
                                                  }));
                                                  debugPrint("Opening camera");
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: GestureDetector(
                                                child: new Text(
                                                  'Select from gallery',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                onTap: () async {
                                                  var gallery =
                                                      await ImagePicker
                                                          .pickImage(
                                                    source: ImageSource.gallery,
                                                  );
                                                  debugPrint("Opening gallery");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                        RaisedButton(
                          color: Colors.purple,
                          child: Text("VR view"),
                          onPressed: () {
                            debugPrint("Working");
                            _launchURL();
                          },
                        ),
                      ],
                    )),
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
//                  DataColumn(
//                    label: Text(
//                      "Progress\/\nEvidences",
//                      style: kOrderText,
//                    ),
//                    numeric: false,
//                    tooltip: "More Info",
//                  ),
                      DataColumn(
                        label: Text(
                          " ",
                          style: kOrderText,
                        ),
                        numeric: false,
                        tooltip: "Add evidences",
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
