import 'package:flutter/material.dart';
import 'package:tool_share/services/authentication/auth_service.dart';
import '../../widget/my_button.dart';
import '../../widget/my_textFied.dart';
import '../../widget/social_button.dart';
import 'create_an_account.dart';


class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignUpScreen({super.key, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 50),

              // welcome message
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                hintText: "email",
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 25),

              // password textfield
              MyTextField(
                hintText: "password",
                obscureText: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 25),

              // login button
              MyButton(
                  text: "Register",
                  onTap: register
              ),

              const SizedBox(height: 25),

              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Already have an account? ",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary
                      )
                  ),

                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                        "Login now",
                        style: TextStyle(color: Theme.of(context).colorScheme.primary
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }

  void register() {
    // get auth service
    final _auth = AuthService();

    _auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);

  }

  final void Function()? onTap;
}