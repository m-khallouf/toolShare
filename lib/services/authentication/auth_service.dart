import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with google
  signInWithGoogle() async {
    // Initialize GoogleSignIn with clientId
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: "436096649025-jnv0p4k5qnd5r8dqm18p85b3d7ls5h1u.apps.googleusercontent.com",
    );

    // begin interactive sign in process
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    // obtain auth detail from request
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // finally sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign in with email
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword (
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  // sing up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword (
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  // sing out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}