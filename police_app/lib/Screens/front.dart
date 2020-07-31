import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police_app/Components/peakcurve.dart';
import 'package:police_app/Screens/options.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';
import 'login.dart';

class FrontPage extends StatefulWidget {
  static String id = "/";
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnDUTY',
          style: kTitleResult,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Container(
              height: 30.0,
              child: TyperAnimatedTextKit(
                  speed: Duration(milliseconds: 75),
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "नमस्कार, त्रिपाठी जी",
//                        "नमस्कार, त्रिपाठी जी",
                  ],
                  textStyle: kOrderStyle
//                          TextStyle(fontSize: 10.0, fontFamily: "Bobbers"),
                  ),
            ),
          ),
          Hero(
            tag: 'dash',
            flightShuttleBuilder: (BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext) {
              final Hero toHero = toHeroContext.widget;
              return ScaleTransition(
                scale: animation.drive(
                  Tween<double>(begin: 0.0, end: 1.0).chain(
                    CurveTween(
                      curve: Interval(0.0, 1.0, curve: PeakQuadraticCurve()),
                    ),
                  ),
                ),
                child: toHero.child,
              );
            },
            child: Image.asset(
              "assets/images/police.png",
//            height: 400.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
//                onPressed: () async => {
//                  await print(traslateOrders.getTranslatedOrders().toString()),
                onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (_, __, ___) => Options())),

                disabledBorderColor: Colors.cyanAccent,
                focusColor: Colors.black,
//                      textColor: Colors.white,
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3.0,
                ),
                child: Text(
                  "Current User",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              OutlineButton(
//                onPressed: () async => {
//                  await print(traslateOrders.getTranslatedOrders().toString()),
                onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 700),
                        pageBuilder: (_, __, ___) => LoginPage())),

                disabledBorderColor: Colors.cyanAccent,
                focusColor: Colors.black,
//                      textColor: Colors.white,
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3.0,
                ),
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              OutlineButton(
                onPressed: () {
                  return Alert(
                    style: AlertStyle(
                      titleStyle: TextStyle(
                        color: Colors.blue,
                      ),
                      descStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 16.5,
                        fontStyle: FontStyle.italic,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    context: context,
                    title: "Username: Arun Tripathi",
                    desc: "You're already logged in.",
                    content: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          "To log in with different user, press \"New Login\"",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "To continue with the current id, press \"OK\"",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        color: Colors.blueAccent,
                        child: Text("New Login"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 700),
                                  pageBuilder: (_, __, ___) => Options()));
                        },
                      ),
                      DialogButton(
                        color: Colors.blueAccent,
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 600),
                                  pageBuilder: (_, __, ___) => Options()));
                        },
                      )
                    ],
                  ).show();
                },
                disabledBorderColor: Colors.cyanAccent,
                focusColor: Colors.black,
//                      textColor: Colors.white,
                borderSide: BorderSide(
                  color: Colors.cyan,
                  width: 3.0,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
