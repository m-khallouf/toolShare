import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_share/firebase_options.dart';
import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/utilities/export_all_themes.dart';
import 'cc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print("🔥 Firebase initialized successfully!");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }

  // Wrap the app in a try-catch to catch runtime errors
  try {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print("❌ App launch error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
