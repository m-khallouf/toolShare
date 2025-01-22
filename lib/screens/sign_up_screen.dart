import 'package:flutter/material.dart';
import '../widget/social_button.dart';
import 'create_an_account.dart';


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
                        SocialButton(imagePath: 'images/appleIcon.png', text: 'continue with Apple',
                          onPressed: () {
                            // TODO: Handle Apple login
                          },
                        ),
                        const SizedBox(height: 20.0),
                        SocialButton(imagePath: 'images/googleIcon.png', text: 'continue with Google',
                          onPressed: () {
                            // TODO: Handle Google login
                          },
                        ),

                        const SizedBox(height: 20.0),
                        SocialButton(imagePath: 'images/emailIcon.png', text: 'continue with email',
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAnAccountScreen(),),);
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