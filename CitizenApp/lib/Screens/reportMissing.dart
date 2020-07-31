import 'package:citizen_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Report extends StatefulWidget {
  static String id = 'report';
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _image;
  final picker = ImagePicker();
  bool dispButton = true;
  final firestore = Firestore.instance;
  String name, lastSeen, desc;
  final nameController = TextEditingController();
  final lastSeenController = TextEditingController();
  final descController = TextEditingController();
  bool _empty = false;

  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = pickedFile.path;
      print(_image);
      dispButton = false;
    });
  }

  Future getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile.path;
      print(_image);
      dispButton = false;
    });
  }

  Future<void> _showPictureDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Take a picture'),
                onPressed: () {
                  getCamera();
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text('Choose from gallery'),
                onPressed: () {
                  getGallery();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      appBar: AppBar(
        title: Text(
          'Report',
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
              Container(
                margin:
                    dispButton ? EdgeInsets.only(top: 40, bottom: 30) : null,
                child: dispButton
                    ? FlatButton(
                        color: Color(0xFF3282b8),
                        onPressed: () {
                          _showPictureDialog(context);
                        },
                        child: Text('Upload'),
                      )
                    : Flexible(
                        child: Image.file(
                        File(_image),
                        width: 300,
                        height: 300,
                      )),
              ),
              TextField(
                controller: nameController,
                onChanged: (value) {
                  name = value;
                },
                decoration: kTextBoxDecoration.copyWith(
                  hintText: 'Missing Person Name',
                  errorText: _empty ? 'Field cannot be empty' : null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: lastSeenController,
                onChanged: (value) {
                  lastSeen = value;
                },
                decoration: kTextBoxDecoration.copyWith(hintText: 'Last Seen'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextField(
                  controller: descController,
                  onChanged: (value) {
                    desc = value;
                  },
                  maxLines: 20,
                  decoration: kTextBoxDecoration.copyWith(
                      hintText: 'Description of the incident'),
                ),
              ),
              FlatButton(
                child: Text('Submit'),
                color: Color(0xFF3282b8),
                onPressed: () {
                  setState(() {
                    nameController.text.isEmpty
                        ? _empty = true
                        : _empty = false;
                    if (!_empty) dispButton = true;
                  });
                  if (!_empty) {
                    nameController.clear();
                    descController.clear();
                    lastSeenController.clear();
                    firestore.collection('Report Missing').add({
                      'name': name,
                      'description': desc,
                      'last seen': lastSeen,
                      'image': _image
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
