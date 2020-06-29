import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> _verifyUser(FirebaseUser user) async {
    if (user == null || await user.getIdToken() == null || user.email == null)
      return false;

    final cUser = await auth.currentUser();
    if (user.uid != cUser.uid) return false;

    return true;
  }

  Future<FirebaseUser> loginGoogle() async {
    final googleAccount = await googleSignIn.signIn();

    assert(googleAccount != null, 'ERROR_LOGIN_CANCELLED');

    final googleAuth = await googleAccount.authentication;
    final credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final r = await auth.signInWithCredential(credential);
    final user = r.user;
    if (await _verifyUser(user)) {
      print(user.uid);
      return user;
    } else {
      print('FAIL');
      return null;
    }
  }

  Future<FirebaseUser> loginEmail(email, password) async {
    final r =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final user = r.user;

    if (await _verifyUser(user)) {
      print(user.uid);
      return user;
    } else {
      print('FAIL');
      return null;
    }
  }

  Future<FirebaseUser> signUpEmail(email, password) async {
    final r = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = r.user;

    if (await _verifyUser(user)) {
      print(user.uid);
      return user;
    } else {
      print('FAIL');
      return null;
    }
  }

  Future logout() async {
    auth.signOut();
    googleSignIn.signOut();
  }

  Future redefinePassword(email) async =>
      await auth.sendPasswordResetEmail(email: email);

  Future removeAccount() async => await (await auth.currentUser()).delete();
}
