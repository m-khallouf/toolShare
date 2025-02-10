import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_auth.dart';

class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? error;

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

              // email text-field
              MyTextField(
                hintText: "email",
                obscureText: false,
                controller: _emailController,
                errorText: error,
              ),

              const SizedBox(height: 25),

              // password text-field
              MyTextField(
                hintText: "password",
                obscureText: true,
                controller: _passwordController,
                errorText: error,
              ),

              const SizedBox(height: 25),

              // login button
              MyButton(
                  text: "Register",
                  onTap: register,
                color: Theme.of(context).colorScheme.secondary,
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
    final auth = AuthService();

    auth.signUpWithEmailAndPassword(_emailController.text, _passwordController.text);

  }

  final void Function()? onTap;
}