import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_login_sign_up.dart';
import 'package:tool_share/services/security/sql_injection.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  bool showInjectionScreen = false;  // Flag to track whether to show the injection screen

  void toggleScreens() {
    if (!showInjectionScreen) {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showInjectionScreen) {
      return const InjectionDetectedScreen(); // Show the SQL injection screen
    }

    if (showLoginPage) {
      return LoginScreen(
        onTap: toggleScreens,
      );
    } else {
      return SignUpScreen(
        onTap: toggleScreens,
      );
    }
  }

  // This method will be used to show the SQL injection screen when needed
  void showSQLInjectionScreen() {
    setState(() {
      showInjectionScreen = true;
    });
  }
}
