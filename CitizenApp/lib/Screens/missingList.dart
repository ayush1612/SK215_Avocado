import 'package:citizen_app/Model/missingCardWidget.dart';
import 'package:citizen_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayLost extends StatelessWidget {
  static String id = 'found';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        title: Text(
          'Found',
          style: kAppBarTextStyle,
        ),
        flexibleSpace: Container(
          decoration: kAppBarBoxDecoration,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              LostDetailStream(),
            ],
          ),
        ),
      ),
    );
  }
}

class LostDetailStream extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("Report Missing").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          List<MissingCardWidget> listOfMissing = [];
          final snapshots = snapshot.data.documents;
          String name, desc, image, lastSeen;

          for (var missing in snapshots) {
            name = missing.data['name'];
            desc = missing.data['description'];
            image = missing.data['image'];
            lastSeen = missing.data['last seen'];
            listOfMissing.add(
              MissingCardWidget(
                name: name,
                desc: desc,
                image: image,
                lastSeen: lastSeen,
              ),
            );
          }

          return Expanded(
            child: ListView(
              children: listOfMissing,
            ),
          );
        });
  }
}
