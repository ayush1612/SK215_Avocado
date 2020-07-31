import 'package:citizen_app/Screens/missingDetails.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:citizen_app/constants.dart';

class MissingCardWidget extends StatelessWidget {
  final name;
  final desc;
  final image;
  final lastSeen;

  const MissingCardWidget(
      {@required this.name,
      @required this.desc,
      @required this.image,
      @required this.lastSeen});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kActiveCardColor,
      child: ListTile(
          leading: ClipOval(
            child: Image.file(
              File(image),
              height: 60,
              width: 60,
              fit: BoxFit.fill,
            ),
          ),
          title: Text('$name'),
          subtitle: Text('Last Seen : $lastSeen'),
          trailing: ButtonTheme(
            minWidth: 15,
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LostItem(
                        image: image,
                        name: name,
                        lastSeen: lastSeen,
                        desc: desc),
                  ),
                );
              },
              child: Text('View'),
              color: Color(0xFF3282b8),
            ),
          )),
    );
  }
}
