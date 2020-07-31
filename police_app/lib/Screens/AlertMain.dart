import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'package:police_app/Screens/createGroup.dart';
import 'package:speech_recognition/speech_recognition.dart';

import '../constants.dart';

class AlertMain extends StatefulWidget {
  static String id = 'mainalert';

  @override
  _AlertMainState createState() => _AlertMainState();
}

class _AlertMainState extends State<AlertMain> {
  final db = Firestore.instance;
  var items;
  int i = 1, j = 1;
  SpeechRecognition _speechRecognition;
  String status;
//  List<bool> isSelected = [true, false];
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";
  String activeText = "";
  String buttonText = "";
  bool ngrp = false;
  Row alert;
  String gbtn = "Switch to Group alert";
  String ebtn = "Switch to Emergency alert";
  String mode;
//  Position p;

  Row ealert = Row(
    children: <Widget>[
      Image.asset(
        "assets/images/siren.png",
        width: 200,
        height: 280,
      )
    ],
  );
  Row galert = Row(
    children: <Widget>[
      Image.asset(
        "assets/images/police-team.png",
        width: 200,
        height: 280,
      )
    ],
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    takePermission();
    initSpeechRecognizer();
    setState(() {
      alert = ealert;
      buttonText = gbtn;
      activeText =
          "In emergency mode, the alerts are sent to the control room.";
//          "This is emergency alert room. Use it in emergency cases. Press the mic to record. Press the stop button to stop. Press cancel to cancel the recording. Press confirm to send the recording. The recording will be sent immediately to the control room.";
//      atak = etak;
      mode = "Emergency Mode";
    });
  }

  Future<void> _neverSatisfied(String str, String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Mode Alert',
//            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You are now in ' + str,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.black45, fontSize: 15),
                ),
//                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              color: Colors.blueAccent,
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  takePermission() async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.requestPermissions([
      Permission.RECORD_AUDIO,
    ]);
  }

  FlutterTts flutterTts = FlutterTts();

  Future _speak(text) async {
//    print(await flutterTts.getLanguages);
//    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setVoice("hi-in-x-cfn-network");
    await flutterTts.setSpeechRate(0.47);
    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);

//    print(await flutterTts.getVoices);
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler((bool result) => setState(
          () => _isAvailable = result,
        ));

    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));
    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  void getLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//      Geolocator().placemarkFromCoordinates();
//    List<Placemark> loc = await Geolocator().placemarkFromPosition(position);
    print(position);
//    p = loc[0];
  }

  void recordAlert(txt, type) async {
//    if(type == 'Emergency Mode') {
    await getLocation();

    DocumentReference ref = await db.collection(type).add({
      'alert': txt,
      'timeStamp': new DateTime.now().millisecondsSinceEpoch,
      'sender': 'Arun Tripathi',
      'location': GeoPoint(position.latitude, position.longitude),
//      'place': p,
    });
    print("Added emergency message, id:" + ref.documentID);
//    }
//    _speak(txt);
  }

  StreamBuilder<QuerySnapshot> createEmergencyList(type) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection(type)
            .orderBy("timeStamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final items = snapshot.data.documents;

          List<Padding> itemsWidget = [];
          for (var item in items) {
            if (type == 'Emergency Mode')
              i++;
            else
              j++;
            final padding = Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  _speak(item.data["alert"]);
                },
                child: Container(
//                onTap: ,

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: type == 'Emergency Mode'
                        ? i % 2 == 0
                            ? Colors.yellowAccent
                            : Colors.lightGreenAccent
                        : j % 2 == 0
                            ? Colors.blueAccent
                            : Colors.deepPurpleAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          item.data["alert"],
                          style: TextStyle(
                            color: type == 'Emergency Mode'
                                ? Colors.black
                                : Colors.white,
//                                  fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ": " + item.data["sender"],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
//                                  fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 100,
                ),
              ),
            );
            itemsWidget.add(padding);
          }
          return ListView(
            children: itemsWidget,
          );
        });
  }

  // creating group list
  StreamBuilder<QuerySnapshot> createGroupList() {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('Group Messages')
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          items = snapshot.data.documents;
          final messages = items[0]['messages'];
          List<Padding> itemsWidget = [];
          for (var message in messages) {
//            if (type == 'Emergency Mode')
//              i++;
//            else
            j++;
            final padding = Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: GestureDetector(
                onTap: () {
                  _speak(message['text']);
                },
                child: Container(
//                onTap: ,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: j % 2 == 0
                        ? Colors.blueAccent
                        : Colors.deepPurpleAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: Colors.white,
//                                  fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ": " + message['sender'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  height: 100,
                ),
              ),
            );
            itemsWidget.add(padding);
          }
          return ListView(
            children: itemsWidget,
          );
        });
  }

  Position position;
  Placemark p;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar,
      body: Column(
        children: <Widget>[
          Container(
            color: kActiveCardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Emergency Alerts",
                        style: kItemsStyle,
                        textAlign: TextAlign.center,
                      ),
                      Container(
//                        color: kInactiveCardColor,
                          width: 200,
                          height: 250,
                          child: createEmergencyList('Emergency Mode')),
                    ],
                  ),
                ),
//              SizedBox(
//                width: 10.0,
//              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Group Alerts",
                        style: kItemsStyle,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 200,
                        height: 250,
                        child: createGroupList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
//              SizedBox(
//                width: 5,
//              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  padding: EdgeInsets.only(
                      top: 10, bottom: 10.0, left: 15, right: 15),
//                  disabledColor: Colors.red,
//                shape: ShapeBorder.lerp(Sh, b, t),
                  shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(18.0),
//                    side: BorderSide(color: Colors.white),
                      ),
                  borderSide: BorderSide(
                    color: Colors.cyan,
                    width: 3.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        buttonText,
                        style: TextStyle(
//                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
//                  style: kStyle,
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      if (buttonText == ebtn) {
                        alert = ealert;
                        buttonText = gbtn;
//                        atak = etak;
                        mode = "Emergency Mode";
                        activeText =
                            "In emergency mode, the messages will be sent to the control room.";
//                            "This is emergency alert room. Use it in emergency cases. Press the mic to record. Press the stop button to stop. Press cancel to cancel the recording.Press confirm to send the recording.The recording will be sent immediately to the control room.";
                        ngrp = false;
                      } else {
                        alert = galert;
//                        atak = gtak;
                        buttonText = ebtn;
                        mode = "Group Mode";
                        activeText =
                            "Group Mode is like a portable walkie talkie. Alert your team.";
                        ngrp = true;
                      }
                    });
                    _neverSatisfied(mode, activeText);
                    print("Emergency");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: Colors.cyanAccent,
                    width: 2,
                  ),
                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.plus,
                        size: 12,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "New Group",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onPressed: (ngrp)
                      ? () {
                          print('New Group');
                          Navigator.pushNamed(context, CreateGroup.id);
                        }
                      : null,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(child: alert, width: 220, height: 210),
                  Text(
                    mode,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 220,
                    height: 220,
                    child: TyperAnimatedTextKit(
                      speed: Duration(milliseconds: 75),
                      onTap: () {
                        print("Tap Event");
                      },
                      text: [
                        "Press the mic to record. Press the stop button to stop. Press cancel to cancel the recording.Press confirm to send the recording.",
                        "Group Mode is used to notify the team. Emergency mode to be used in emergency situtations to notify the authorities.",
//                        "Emergency Mode is used in emergency situations. Use it to notify the control room."
//                          activeText,
//                        "नमस्कार, त्रिपाठी जी",
//                        "नमस्कार, त्रिपाठी जी",
                      ],
                      textStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
//                          TextStyle(fontSize: 10.0, fontFamily: "Bobbers"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        mini: true,
                        splashColor: Colors.blue,
                        heroTag: 'btn1',
                        child: Icon(Icons.cancel),
                        backgroundColor: Colors.greenAccent,
                        onPressed: () {
                          if (_isListening) {
                            _speechRecognition
                                .cancel()
                                .then((result) => setState(() {
                                      resultText = "";
                                      _isListening = result;
                                    }));
                          }
                        },
                      ),
                      FloatingActionButton(
                        heroTag: 'btn2',
                        child: Icon(Icons.mic),
                        backgroundColor: Colors.blue,
                        onPressed: () {
                          if (_isAvailable && !_isListening) {
                            _speechRecognition
                                .listen(locale: "hi_IN")
                                .then((result) {});
                          }
                        },
                      ),
                      FloatingActionButton(
                        mini: true,
                        heroTag: 'btn3',
                        child: Icon(Icons.stop),
                        backgroundColor: Colors.purple,
                        onPressed: () {
//                      doTask();
                          if (_isListening) {
                            _speechRecognition.stop().then(
                                  (result) => setState(() {
                                    _isListening = result;
                                  }),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: 150,
            decoration: BoxDecoration(
//              color: Colors.cyanAccent[100],
              color: kActiveCardColor,
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Text(
              resultText,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Confirm",
//                  style: kItemsStyle,
                ),
                onPressed: () {
                  if (mode == 'Emergency Mode')
                    recordAlert(resultText, mode);
                  else {
                    List currMess = items[0]['messages'];
                    currMess.add({
                      'sender': 'Arun Tripathi',
                      'text': resultText,
                      'timeStamp': DateTime.now()
                    });
                    items[0].reference.updateData({'messages': currMess});
                  }
                  print("Confirmation");
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Cancel"),
                onPressed: () {
                  setState(() {
                    resultText = "";
                  });
                  print("Cancel");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
