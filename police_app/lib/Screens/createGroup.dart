import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/constants.dart';

class CreateGroup extends StatefulWidget {
  static String id = '/creategroup';
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _firestore = Firestore.instance;
  var policeGroup = [];
  bool addbtn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    policeGroup = [];
    addbtn = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add the police in your group and then press 'Create Group' to create a group",
                style: kTopText,
              ),
            ),
          ),
          StreamBuilder(
            stream: _firestore.collection('ThanaPolice').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
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
//                  DataCell(Text(item['pos'] != null ? item['pos'] : ' ')),
                  DataCell(OutlineButton(
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                    onPressed: (item['active'] == false)
                        ? () {
                            setState(() {
                              policeGroup.add(
                                  {'name': item['name'], 'id': item['pid']});
                            });
                            item.reference
                                .updateData(<String, dynamic>{'active': true});
                          }
                        : () {
                            setState(() {
//                              policeGroup.remove(
//                                  {'name': item['name'], 'id': item['pid']});
                              policeGroup.removeWhere(
                                  (val) => val['name'] == item['name']);
                            });
                            item.reference
                                .updateData(<String, dynamic>{'active': false});
                          },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          (item['active']) ? null : Icons.add,
                          size: 15,
                        ),
                        Text((item['active']) ? 'Remove' : 'Add'),
                      ],
                    ),
                  ))
                ]);
                unitPolice.add(policeDetails);
              }
              return ReusableCard(
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
//                    DataColumn(
//                      label: Text(
//                        'Position',
//                        style: kTableLabels,
//                      ),
//                    ),
                    DataColumn(
                      label: Text(''),
                    )
                  ],
                  rows: unitPolice,
                ),
              );
            },
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 10, 18, 10),
              child: Text(
                'Create Group',
                style: kOrderStyle,
              ),
            ),
            onPressed: () {
              print(policeGroup);

              List<String> names = [];
              for (var police in policeGroup) names.add(police['name']);

              _firestore.collection('Group Messages').add({
                'date': DateTime.now(),
                'members': policeGroup,
                'messages': [
                  {
                    'text': 'Hi! Send alerts to ' + names.toString(),
                    'sender': 'server',
                    'timeStamp': DateTime.now()
                  }
                ]
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
