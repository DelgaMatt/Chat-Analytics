import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;

class FirebaseAuthController {
  final _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn
        .signOut()
        .then((response) => print("success"))
        .catchError((e) => print("catch $e"));
  }
}
