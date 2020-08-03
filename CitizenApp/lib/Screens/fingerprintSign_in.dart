import 'package:citizen_app/Screens/otpSign_in.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'HomePage.dart';
import 'package:citizen_app/constants.dart';

class FingerprintScan extends StatefulWidget {
  @override
  _FingerprintScanState createState() => _FingerprintScanState();
}

class _FingerprintScanState extends State<FingerprintScan> {
  final auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    if (authenticated) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print(authenticated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        appBar: AppBar(
          backgroundColor: kBackgroundColour,
          title: Center(
            child: Text(
              'Citizen App',
              style: kAppBarTextStyle,
            ),
          ),
          flexibleSpace: Container(
            decoration: kAppBarBoxDecoration,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _authenticate,
                  child: LongCard(
                      head: 'Fingerprint',
                      subHead: 'Sign In with Fingerprint',
                      img: "assets/img/fingerprint.gif"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OTPSignIn()));
                  },
                  child: LongCard(
                      head: 'OTP',
                      subHead: 'Sign In with OTP',
                      img: 'assets/img/lock.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LongCard extends StatelessWidget {
  const LongCard(
      {@required this.head, @required this.subHead, @required this.img});

  final String head;
  final String subHead;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          TextContainer(
            head: head,
            subHead: subHead,
          ),
          ImageContainer(
            img: img,
          ),
        ],
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({@required this.head, @required this.subHead});
  final String head;
  final String subHead;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(height: 4.0),
            new Text(
              head,
              style: kHeaderTextStyle,
            ),
            new Container(height: 10.0),
            new Text(subHead, style: kSubHeaderTextStyle),
            new Container(
                margin: new EdgeInsets.symmetric(vertical: 8.0),
                height: 2.0,
                width: 18.0,
                color: Color(0xff00c6ff)),
          ],
        ),
      ),
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
          color: new Color(0xFF1D1E33),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0))
          ]),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    @required this.img,
  });

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(img),
        height: 92.0,
        width: 92.0,
      ),
    );
  }
}
