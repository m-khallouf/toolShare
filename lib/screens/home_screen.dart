import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'homeScreen',
          style: TextStyle(),
        ),
      ),
    );
  }
}