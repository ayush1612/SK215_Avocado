import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';

import '../constants.dart';

class CriminalDetails extends StatefulWidget {
  static String id = "/criminal";
  CriminalDetails({this.name, this.crime});
  final name;
  final crime;
  @override
  _CriminalDetailsState createState() => _CriminalDetailsState();
}

class _CriminalDetailsState extends State<CriminalDetails> {
  String name;
  String crime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name = widget.name;
      crime = widget.crime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Criminal Details',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Image.asset("assets/images/criminal.png"),
          ),
          ReusableCard(
            colour: kActiveCardColor,
            cardChild: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),
              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "NAME :",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Righteous',
                              color: Colors.cyanAccent),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "       " + name,
                          style:
                              TextStyle(fontSize: 15, color: Colors.greenAccent
//                            fontFamily: 'Pacifico',
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "CRIME :",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Righteous',
                              color: Colors.cyanAccent),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "       " + crime,
                          style: TextStyle(
                            fontSize: 15, color: Colors.greenAccent,
//                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "CRIMINAL\n HISTORY :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "1. Stolen a bike in 2017.\n2. Murdered the owner.\n",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "ACTIVE\n CASES :",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Righteous',
                            color: Colors.cyanAccent,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "  1. Section 300 IPC ,1860.\n  2. Section 299 IPC,1860\n",
                          style:
                              TextStyle(fontSize: 15, color: Colors.greenAccent
//                            fontFamily: 'Pacifico',
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "CITY :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "         Bengaluru",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "STATE :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "      KARNATAKA",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
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
                          "DOB :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "         10/10/1998",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
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
                          "Height :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "       5 '10 \" ",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
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
                          "GENDER :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "    Male",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Blood Type :",
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'Righteous'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "AB+",
                            style: TextStyle(
                              fontSize: 15,
//                            fontFamily: 'Pacifico',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Weight :",
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Righteous'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "        62 kg",
                          style: TextStyle(
                            fontSize: 15,
//                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
