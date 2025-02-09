import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/navbar_screen.dart';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();

class InjectionDetectedScreen extends StatefulWidget {
  const InjectionDetectedScreen({Key? key}) : super(key: key);

  @override
  _InjectionDetectedScreenState createState() => _InjectionDetectedScreenState();
}
late String _countdownTime;

class _InjectionDetectedScreenState extends State<InjectionDetectedScreen> {
  late Timer _timer;
  int _seconds = 60 * 60 * 24 * 365 * 100; // 100 years in seconds

  @override
  void initState() {
    super.initState();
    _countdownTime = _formatTime(_seconds);
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
          _countdownTime = _formatTime(_seconds);
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int days = seconds ~/ (24 * 3600);
    int hours = (seconds % (24 * 3600)) ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secondsLeft = seconds % 60;
    return '$days days, $hours hours, $minutes minutes, $secondsLeft seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 330,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(  // Added Column to wrap multiple children inside the container
                  children: [
                    Image.asset(
                      'images/sql.jpg',
                      width: 400,
                      height: 400,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SOMETHING SMELLS FISHY AND IT CERTAINLY ISN\'T FISH',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Time remaining: $_countdownTime',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}