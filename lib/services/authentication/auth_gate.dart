import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/screens/navbar_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? const BottomNavBar()
                : const LoginOrRegister();
          }),
    );
  }
}
