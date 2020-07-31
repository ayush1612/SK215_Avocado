import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:police_app/Screens/options.dart';

import '../constants.dart';

class PhoneAuth extends StatefulWidget {
  static String id = '/phoneAuth';
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            backgroundColor: Colors.white70,
            title: Text(
              'Enter SMS Code',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Container(
//              color: Colors.white70,
              height: 85,
              child: Column(children: [
                TextField(
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              RaisedButton(
                textTheme: ButtonTextTheme.primary,
                color: Colors.lightBlue,
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, Options.id);
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

//      Navigator.of(context).pop();
      Navigator.pushNamed(context, Options.id);
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('OTP sign in successfull');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 350, child: Image.asset('assets/images/police2.png')),
            Padding(
              padding: EdgeInsets.all(12),
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter Phone Number '),
                    onChanged: (value) {
                      this.phoneNo = '+91' + value;
                    },
                  ),
                ),
              ),
            ),
            (errorMessage != ''
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();
              },
              child: Text('Verify'),
              textColor: Colors.white,
              elevation: 7,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
