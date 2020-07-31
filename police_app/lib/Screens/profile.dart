import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';

class Profile extends StatefulWidget {
  static String id = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    TextStyle kDetails = TextStyle(
        color: Colors.white,
        letterSpacing: 1.7,
        fontWeight: FontWeight.w500,
        fontSize: 14);

    return Scaffold(
      appBar: kAppBar,
      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'My Profile',
//            textAlign: TextAlign.center,
              style: kOrderStyle,
            ),
          ),
          Image.asset(
            'assets/images/police2.png',
            height: 250,
          ),
//          ReusableCard(
//            colour: kActiveCardColor,
          Container(
            color: kActiveCardColor,
//            width: 300,
            height: 500,
            child: ListView(
              children: <Widget>[
                DataTable(columns: [
                  DataColumn(
                    label: Text('Attributes', style: kTableLabels),
                  ),
                  DataColumn(
                    label: Text('Details', style: kTableLabels),
                  )
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      'Officer Id',
                      style: kDetails,
                    )),
                    DataCell(Text(
                      'MK54D65',
                      style: kDetails,
                    ))
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        'Name',
                        style: kDetails,
                      ),
                    ),
                    DataCell(
                      Text(
                        'Arun Tripathi',
                        style: kDetails,
                      ),
                    )
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        'Position / Rank',
                        style: kDetails,
                      ),
                    ),
                    DataCell(Text(
                      'Police Chief',
                      style: kDetails,
                    ))
                  ]),
                  DataRow(cells: [
                    DataCell(
                      Text(
                        'Years Active',
                        style: kDetails,
                      ),
                    ),
                    DataCell(
                      Text(
                        '2008 - Present(12 Years)',
                        style: kDetails,
                      ),
                    )
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      'Thana',
                      style: kDetails,
                    )),
                    DataCell(Text(
                      'Marathahalli Jila Thana',
                      style: kDetails,
                    ))
                  ]),
                  DataRow(cells: [
                    DataCell(Text(
                      'Cases Handled',
                      style: kDetails,
                    )),
                    DataCell(Text(
                      '303',
                      style: kDetails,
                    ))
                  ]),
//                  DataRow(cells: [
//                    DataCell(
//                      Text('Digital Signature', style: kDetails),
//                    ),
//                    DataCell(
//                      Container(
////                          height: 100,
////                          width: 100,
//                          child: Image.asset('assets/images/sign.jpeg')),
//                    ),
//                  ]),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Digital Signature', style: kDetails),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                        height: 150,
                        width: 200,
                        child: Image.asset('assets/images/sign.jpeg')),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
//              ),
            ),
          )
        ],
      ),
    );
  }
}
