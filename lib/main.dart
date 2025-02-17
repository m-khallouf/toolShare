import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_share/firebase_options.dart';

import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/utilities/export_all_themes.dart';


import 'cc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);

  UserIDPrinter userIDPrinter = UserIDPrinter();
  userIDPrinter.printCurrentUserId();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable Device Preview only in debug mode
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // AuthGate
      home: AuthGate(),

      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}