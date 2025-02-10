import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/services/authentication/auth_service.dart';
import 'package:tool_share/widget/my_button.dart';
import 'package:tool_share/widget/my_textFied.dart';
import 'package:tool_share/widget/providerSignInTile.dart';
import '/screens/navbar_screen.dart';
import '../../widget/social_button.dart';
import 'sign_up_screen.dart';
import 'package:tool_share/services/security/sql_injection.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.onTap});

  // Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // welcome message
              Text(
                "welcome back",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "forgot password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),

                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // login button
              MyButton(
                  text: "Login",
                  onTap: () => login(context),
                color: Theme.of(context).colorScheme.secondary,
              ),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),

                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Text(" Or Sign In with "),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // apple
                  ProviderSignInTile(
                    onTap: () {},
                      imagePath: "../images/appleIcon.png"
                  ),

                  const SizedBox(width: 20),

                  // google
                  ProviderSignInTile(
                    onTap: () => AuthService().signInWithGoogle(),
                      imagePath: "../images/googleIcon.png"
                  ),
                ],
              ),

              const SizedBox(height: 25),
              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Don\'t have an account? ",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary
                      )
                  ),

                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blue)
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }

  void login(BuildContext context) async{
    // auth service
    final authService = AuthService();

    // login
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text
      );
    } catch (errors) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(errors.toString())));
    }

  }

  final void Function()? onTap;
}