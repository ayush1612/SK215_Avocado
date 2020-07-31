import 'package:flutter/material.dart';
import 'package:police_app/constants.dart';

import '../Components/NewsGenerator.dart';

class News extends StatefulWidget {
  static String id = '/news';

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  String dropdownValue = 'national';
  Widget currNewsWid;
  var newsData = null;
  NewsGenerator ng = new NewsGenerator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: kAppBar,
        body: Center(
          child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('News',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  size: 25,
                ),
//                iconSize: 30,
//                elevation: 16,
                style: TextStyle(
//                    color: Colors.greenAccent,
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                    fontSize: 20),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    newsData = null;
                    currNewsWid = ng.makeList(dropdownValue);
                  });
                },
                items: <String>[
                  'national',
                  'business',
                  'sports',
                  'world',
                  'politics',
                  'technology',
                  'startup',
                  'entertainment',
                  'miscellaneous',
                  'hatke',
                  'science',
                  'automobile'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ng.makeList(dropdownValue),
              )
            ],
          ),
        ));
  }
}
