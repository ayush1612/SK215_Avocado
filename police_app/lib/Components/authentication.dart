import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:police_app/Screens/front.dart';

import '../constants.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String email = user.email;
    print('$email successfully signed in');
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

//    Navigator.pushNamed(context, FrontPage.id);
//    Navigator.push(
//        context,
//        PageRouteBuilder(
//            transitionDuration: Duration(milliseconds: 600),
//            pageBuilder: (_, __, ___) => FrontPage()));
//    Get.to(FrontPage());
    navigatorKey.currentState.pushNamed(FrontPage.id);
    print("User Sign Out");
  }
}
