import 'package:firebase_auth/firebase_auth.dart';

class UserIDPrinter {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void printCurrentUserId() {
    User? user = _auth.currentUser;

    if (user != null) {
      print('Current User ID: ${user.uid}');
    } else {
      print('No user is currently signed in.');
    }
  }
}
