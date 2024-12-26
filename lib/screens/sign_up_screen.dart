import 'package:flutter/material.dart';
import '../widget/social_button.dart';


class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Text('Sign Up', style: TextStyle(fontSize: 30)),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SocialButton(imagePath: 'images/apple.png', text: 'continue with Apple',
                          onPressed: () {
                            // Handle Apple login
                          },
                        ),
                        const SizedBox(height: 20.0),
                        SocialButton(imagePath: 'images/google.png', text: 'continue with Google',
                          onPressed: () {
                            // Handle Google login
                          },
                        ),

                        const SizedBox(height: 20.0),
                        SocialButton(imagePath: 'images/email.png', text: 'continue with email',
                          onPressed: () {
                            // Handle email login
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}