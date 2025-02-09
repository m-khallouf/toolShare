import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';
import 'package:tool_share/services/authentication/auth_gate.dart';
import 'package:tool_share/services/authentication/login_or_register.dart';
import 'package:tool_share/firebase_options.dart';
import 'package:tool_share/screens/login_signup/sign_up_screen.dart';
import 'screens/login_signup/login_screen.dart';
import 'themes/light_mode.dart';
import 'themes/dark_mode.dart';

import 'package:tool_share/screens/profile/profile/published_ad_or_not.dart';

import 'package:firebase_core/firebase_core.dart';


import 'cc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);



  /*
    // Create an instance of PublishedAdOrNot
  PublishedAdOrNot publishedAdOrNot = PublishedAdOrNot();

  // Call the checkUser Offers method
  await publishedAdOrNot.checkUserOffers();
  * */
  UserIDPrinter userIDPrinter = UserIDPrinter();
  userIDPrinter.printCurrentUserId();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // AuthGate
      home: AuthGate(),

      theme: lightMode,
    );
  }
}