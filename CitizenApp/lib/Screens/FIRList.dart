import 'package:citizen_app/Model/FIRCard.dart';
import 'package:citizen_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _firestore = Firestore.instance;

class FIRStatus extends StatefulWidget {
  static String id = 'firStatus';
  @override
  _FIRStatusState createState() => _FIRStatusState();
}

class _FIRStatusState extends State<FIRStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        title: Text(
          'FIRs',
          style: kAppBarTextStyle,
        ),
        flexibleSpace: Container(
          decoration: kAppBarBoxDecoration,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            FIRCardsStream(),
          ],
        ),
      ),
    );
  }
}

class FIRCardsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("FIR").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'No FIRs Filed',
                style: kWidgetNormalText,
              ),
            ),
          );
        }
        List<FIRCard> cards = [];
        final snapshots = snapshot.data.documents;
        for (var field in snapshots) {
          if (field.data['name'] == 'Ayush') {
            var date =
                new DateTime.fromMicrosecondsSinceEpoch(field.data['date'])
                    .toString()
                    .substring(0, 10);
            var crime = field.data['event'];
            var id = field.documentID;
            cards.add(
              FIRCard(
                  id: id.substring(0, id.length - 6),
                  data: field,
                  date: date,
                  crime: crime),
            );
          }
        }
        if (cards.length == 0) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'No FIRs Filed',
                style: kWidgetNormalText,
              ),
            ),
          );
        }
        return Expanded(
          child: ListView(
            children: cards,
          ),
        );
      },
    );
  }
}
