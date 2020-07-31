import 'package:flutter/material.dart';
import 'package:police_app/Components/phoneAuth.dart';
import 'package:police_app/Screens/createGroup.dart';
import 'package:police_app/Screens/crimereporter.dart';
import 'package:police_app/Screens/criminaldetail.dart';
import 'package:police_app/Screens/evidencedesc.dart';
import 'package:police_app/Screens/front.dart';
import 'package:police_app/Screens/map.dart';
import 'package:police_app/Screens/mostwanted.dart';
import 'package:police_app/Screens/options.dart';
import 'package:police_app/Screens/pdfviewer.dart';
import 'package:police_app/Screens/reportactive.dart';
import 'package:police_app/Screens/reportntrack.dart';
import 'package:police_app/Screens/schedule.dart';
import 'package:police_app/Screens/schedulemain.dart';

import 'Screens/AlertMain.dart';
import 'Screens/constitution.dart';
import 'Screens/criminalrecord.dart';
import 'Screens/evidences.dart';
import 'Screens/login.dart';
import 'Screens/mycases.dart';
import 'Screens/news.dart';
import 'Screens/others.dart';
import 'Screens/profile.dart';
import 'Screens/thana.dart';
import 'Screens/trackevidence.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        navigatorKey: navigatorKey,

//        home: FrontPage());
        initialRoute: FrontPage.id,
        routes: {
          FrontPage.id: (context) => FrontPage(),
          MyCases.id: (context) => MyCases(),
          ReportNTrack.id: (context) => ReportNTrack(),
          CriminalDetails.id: (context) => CriminalDetails(),
          Options.id: (context) => Options(),
          MostWanted.id: (context) => MostWanted(),
          CriminalRecord.id: (context) => CriminalRecord(),
          MySchedule.id: (context) => MySchedule(),
          CrimeReporter.id: (context) => CrimeReporter(),
          ReportActive.id: (context) => ReportActive(),
          MapActive.id: (context) => MapActive(),
          AlertMain.id: (context) => AlertMain(),
          ScheduleMain.id: (context) => ScheduleMain(),
          TrackEvidence.id: (context) => TrackEvidence(),
          Evidences.id: (context) => Evidences(),
          EvidenceDescription.id: (context) => EvidenceDescription(),
          Others.id: (context) => Others(),
          Thana.id: (context) => Thana(),
          PdfViewerPage.id: (context) => PdfViewerPage(),
          Profile.id: (context) => Profile(),
          Constitution.id: (context) => Constitution(),
          LoginPage.id: (context) => LoginPage(),
          PhoneAuth.id: (context) => PhoneAuth(),
          CreateGroup.id: (context) => CreateGroup(),
          News.id: (context) => News(),
        });
  }
}
