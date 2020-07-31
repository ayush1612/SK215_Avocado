import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/constants.dart';

class Police {
  final _firestore = Firestore.instance;

  StreamBuilder<QuerySnapshot> getPolice() {
    print('Police DET');

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('ThanaPolice').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('Indicator');
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final items = snapshot.data.documents;
        List<DataRow> unitPolice = [];
        print('Rows are getting added');
        for (var item in items) {
          final policeDetails = DataRow(cells: [
            DataCell(
              Text(
                item['pid'] == null ? ' ' : item['pid'],
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.25,
                ),
              ),
            ),
            DataCell(
              Text(item['name'] != null ? item['name'] : ' '),
            ),
            DataCell(Text(item['pos'] != null ? item['pos'] : ' '))
          ]);
          unitPolice.add(policeDetails);
        }
        return Column(
          children: <Widget>[
            ReusableCard(
              colour: kActiveCardColor,
              cardChild: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("This is the list of police in your current thana",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.lightBlueAccent,
                      letterSpacing: 2.0,
                      wordSpacing: 2.0,
                    )),
              ),
            ),
            ReusableCard(
              colour: kActiveCardColor,
              cardChild: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'PID',
                      style: kTableLabels,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Name',
                      style: kTableLabels,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Position',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontSize: 15),
                    ),
                  ),
                ],
                rows: unitPolice,
              ),
            ),
          ],
        );
      },
    );
  }
}
