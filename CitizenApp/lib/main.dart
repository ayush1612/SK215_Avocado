//import 'package:citizen_app/Screens/HomePage.dart';
import 'package:citizen_app/Screens/fingerprintSign_in.dart';
import 'package:flutter/material.dart';
import 'package:citizen_app/Screens/ProfilePage.dart';
import 'package:citizen_app/Screens/HelpPage.dart';
import 'package:citizen_app/Screens/FIRList.dart';
import 'package:citizen_app/Screens/missingList.dart';
import 'package:citizen_app/Screens/missing.dart';
//import 'package:citizen_app/Screens/pdfViewer.dart';
import 'package:citizen_app/Screens/reportMissing.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData.dark(),
    title: "Citizen App",
    home: new FingerprintScan(),
    routes: {
      "firstatus": (context) => FIRStatus(),
      "missing": (context) => Missing(),
      "report": (context) => Report(),
      "profile": (context) => ProfilePage(),
      "help": (context) => HelpPage(),
      "found" : (context) => DisplayLost()
    },
  ));
}
