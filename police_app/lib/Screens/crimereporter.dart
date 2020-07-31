import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import 'map.dart';
import 'options.dart';

class CrimeReporter extends StatefulWidget {
  CrimeReporter({this.bgFile, this.docid});
  static String id = "/crimereport";
  final bgFile;
  final String docid;
  @override
  _CrimeReporterState createState() => _CrimeReporterState();
}

class _CrimeReporterState extends State<CrimeReporter> {
  String city, state, country;
  String docid;
  Placemark p;
  final nameCon = TextEditingController();
  final descCon = TextEditingController();
  final officerCon = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameCon.dispose();
    descCon.dispose();
    officerCon.dispose();

    super.dispose();
  }

  final _firestore = Firestore.instance;
  File bgFile;
  @override
  void initState() {
    super.initState();
    setState(() {
      bgFile = widget.bgFile;
      city = state = country = null;
      docid = widget.docid;
    });
  }

  Position position;
//  final Location location = Location();
  @override
  Widget build(BuildContext context) {
    void getLocation() async {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//      Geolocator().placemarkFromCoordinates();
      List<Placemark> loc = await Geolocator().placemarkFromPosition(position);
      print(position);
      p = loc[0];
    }

    return Scaffold(
      appBar: kAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.file(
                      bgFile,
//                    "assets/images/evidence.jpeg",
                      height: 150.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Image :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 300,
                          height: 40,
                          child: Text(
//                        "      file://DCIM/camera/New_doc090220",
                            bgFile.path,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
//                            fontFamily: 'Pacifico',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Evidence: ',
                          style: kItemsStyle,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter evidence name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    controller: nameCon,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Officer',
                          style: kItemsStyle,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Officer's name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    controller: officerCon,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Decsription of the incident',
                          style: kItemsStyle,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter all the details",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    controller: descCon,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.blue,
//            borderSide: BorderSide(
//              color: Colors.white,
//              width: 3.0,
//            ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () async {
                      await getLocation();
                      return Alert(
                        style: AlertStyle(
                          titleStyle: TextStyle(
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        context: context,
                        title: "Submitted",
                        image: Image.file(
                          bgFile,
//                        "assets/images/evidence.jpeg",
                          height: 150,
                          width: 200,
                        ),
                        desc: "Added the evidence successfully!",
                        content: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Image :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Righteous',
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 60,
                                    child: Text(
//                                    "file://DCIM/camera/New_doc090220",
                                      bgFile.path,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
//                            fontFamily: 'Pacifico',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Location :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Righteous',
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 60,
                                    child: Text(
//                                  "Mathikere, Bengaluru,\n Karnataka 560054",
                                      p.locality.toString() +
                                          ", " +
                                          p.administrativeArea.toString() +
                                          ", " +
                                          p.country +
                                          ", " +
                                          p.postalCode,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey
//                            fontFamily: 'Pacifico',
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ReusableCard(
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MapActive(
                                        p: p.position,
                                      );
                                    },
                                  ),
                                );
                              },
                              cardChild: Image.asset(
                                "assets/images/map_evidence.png",
                              ),
                            ),
                            Text(
                              "Click on the map to track the location.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
//                              fontFamily: 'Pacifico',
                              ),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            color: Colors.blueAccent,
                            child: Text("CONFIRM"),
                            onPressed: () async {
                              await getLocation();
//                            Map<String, Object> allevidences = [{
//                              "try":1,
//                            }];
                              Map<dynamic, dynamic> data = {
                                'name': nameCon.text,
                                'officer': officerCon.text,
                                'desc': descCon.text,
                                'image': bgFile.path,
                                'location': p.locality.toString() +
                                    ", " +
                                    p.name +
                                    ", " +
                                    p.administrativeArea.toString() +
                                    ", " +
                                    p.country +
                                    ", " +
                                    p.postalCode,
                                'geolocation': {
                                  'latitude': position.latitude,
                                  'longitude': position.longitude
                                }
                              };
                              var list = new List<Map<dynamic, dynamic>>();
                              list.add(data);
                              await _firestore
                                  .collection('ActiveCases')
                                  .document(docid)
                                  .setData({
                                'allevidences': FieldValue.arrayUnion(list)
                              }, merge: true);
                              await Navigator.pushNamed(context, Options.id);
                            },
                          )
                        ],
                      ).show();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
