import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';

import '../constants.dart';
import 'evidencedesc.dart';

class Evidences extends StatefulWidget {
  static String id = "/evidences";
  Evidences({this.allevidences});
  final List allevidences;
  @override
  _EvidencesState createState() => _EvidencesState();
}

class _EvidencesState extends State<Evidences> {
  static List items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      items = widget.allevidences;
    });
  }

//  static int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "Evidences",
                style: kOrderStyle,
              ),
            ),
          ),
          Container(
            height: 750,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ReusableCard(
//                elevation: 5,
                  colour: kActiveCardColor,
                  onPress: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EvidenceDescription(
                        desc: items[index]['desc'],
                        officer: items[index]['officer'],
                        loc: items[index]['location'],
                        geoloc: items[index]['geolocation'],
                        image: items[index]['image'],
                      );
                    }))
//                    Navigator.pushNamed(
//                      context,
//                      EvidenceDescription.id,
//                    ),
                  },
                  cardChild: ReusableCard(
                    colour: kInactiveCardColor,
//                  height: 100.0,
                    cardChild: Row(
                      children: <Widget>[
                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/knife.png"),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
//                                  'test',
                                  items[index]['name'],
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 20,
                                    letterSpacing: 1.5,
                                  ),
                                ),
//
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 260,
                                  child: Text("Last Visit : 27/01/20",
                                      style: kItemsStyle),
                                )
//                            ],
//                          ),
//                        ),
//                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
