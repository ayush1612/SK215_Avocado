import 'package:flutter/material.dart';
import 'package:police_app/Components/authentication.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColor = Color(0xFF1D1E33);
const kBottomButtonColor = Color(0xFFEB1555);
const kInactiveCardColor = Color(0xFF111328);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);
const kTableLabels = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
    fontSize: 15);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

//const kBMIText = TextStyle(
//  fontSize: 100.0,
//  fontWeight: FontWeight.bold,
//);

const kTitleResult = TextStyle(
  fontWeight: FontWeight.normal,
  fontSize: 30.0,
  color: Colors.greenAccent,
  fontFamily: 'Courgette',
);
//
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

AppBar kAppBar = AppBar(
  title: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Hero(
        tag: 'dash',
        flightShuttleBuilder: (BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext) {
          final Hero toHero = toHeroContext.widget;
          return RotationTransition(
            turns: animation,
            child: toHero.child,
          );
        },
        child: Image.asset(
          "assets/images/police.png",
          width: 40,
          height: 60,
//            height: 400.0,
        ),
      ),
      SizedBox(
        width: 7,
      ),
      Text(
        "OnDUTY",
        style: kTitleResult,
      ),
      SizedBox(width: 100),
      OutlineButton(
        borderSide: BorderSide(
          color: Colors.lightBlueAccent,
          width: 1.5,
        ),
        child: Text('Logout'),
        onPressed: Authentication().signOutGoogle,
      )
    ],
  ),
);

const kTopText = TextStyle(
  fontStyle: FontStyle.italic,
  color: Colors.lightBlueAccent,
  letterSpacing: 2.0,
  wordSpacing: 2.0,
);

const kOrderStyle = TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);
const kOrderText = TextStyle(
  fontSize: 12.8,
  color: Colors.white,
);
const kItemsStyle = TextStyle(
  fontSize: 16,
);

//const kInputFieldStyle = InputDecoration(
//  hintText: 'Enter a city.',
//  contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
//  border: OutlineInputBorder(
//    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//  ),
//  enabledBorder: OutlineInputBorder(
//    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//  ),
//  focusedBorder: OutlineInputBorder(
//    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//    borderRadius: BorderRadius.all(Radius.circular(32.0)),
//  ),
//);
