//import 'dart:html';

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/map.dart';

import '../constants.dart';

class EvidenceDescription extends StatefulWidget {
  static String id = '/evidencedesc';
  EvidenceDescription(
      {this.desc, this.loc, this.officer, this.geoloc, this.image});
  final String desc;
  final String loc;
  final String officer;
  final String image;
  final geoloc;

  @override
  _EvidenceDescriptionState createState() => _EvidenceDescriptionState();
}

class _EvidenceDescriptionState extends State<EvidenceDescription> {
  String desc;
  String officer;
  String image;
  String loc;
//  var geoloc
  Map<String, dynamic> geoloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      desc = widget.desc;
      officer = widget.officer;
      loc = widget.loc;
      geoloc = widget.geoloc;
      image = widget.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text(
              "Evidence Details",
              style: kOrderStyle,
            ),
          ),
          Container(
            color: Colors.grey,
            width: 360,
            height: 320,
            child: Image.file(File(image)),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 15),
                        child: Text(
                          "DESCRIPTION:",
                          style: TextStyle(
                            fontFamily: "Josefin Sans",
                            fontSize: 18,
                            color: Colors.cyan,

//                        fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        child: Text(
                          desc,
//                          "A blood-stained knife found near the victim's body. Blood-group and the DNA matches the victim. On taking a deeper look, we find that the knife is not an ordinary knife but a kunai knife used by Ninjas of the suburbs. This depicts the criminal is not a local person.",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            letterSpacing: 1.5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 15),
                        child: Text(
                          "EVIDENCE COLLECTED BY:",
                          style: TextStyle(
                            fontFamily: "Josefin Sans",
                            fontSize: 18,
                            color: Colors.cyan,

//                        fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        child: Text(
                          officer,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              letterSpacing: 1.3,
                              color: Colors.white60),
//                            "A blood-stained knife found near the victim's body. Blood-group and the DNA matches the victim. On taking a deeper look, we find that the knife is not an ordinary knife but a kunai knife used by Ninjas of the suburbs. This depicts the criminal is not a local person."),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15, 0, 15),
                        child: Text(
                          "LOCATION:",
                          style: TextStyle(
                            fontFamily: "Josefin Sans",
                            fontSize: 18,
                            color: Colors.cyan,

//                        fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        child: Text(
                          loc,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            letterSpacing: 1.5,
                          ),
//                            "A blood-stained knife found near the victim's body. Blood-group and the DNA matches the victim. On taking a deeper look, we find that the knife is not an ordinary knife but a kunai knife used by Ninjas of the suburbs. This depicts the criminal is not a local person."),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          OutlineButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MapActive(
                      p: Position(
                        longitude: geoloc['longitude'] * 1.0,
                        latitude: geoloc['latitude'] * 1.0,
                      ),
                    );
                  },
                ),
              );
            },
            borderSide: BorderSide(
              color: Colors.cyanAccent,
            ),
//            color: Colors.cyanAccent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                "TRACK",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25,
                  fontSize: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
