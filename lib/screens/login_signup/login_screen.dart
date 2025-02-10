import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? generalError;

  String? errorMessage;

  void _validateAndLogin() async {
    setState(() {
      errorMessage = null;
      emailError = null;
      passwordError = null;
    });

    if (_emailController.text.isEmpty) {
      setState(() {
        emailError = "Please enter your email.";
      });
      return;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Please enter your password.";
      });
      return;
    }

    try {
      await AuthService().signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = "Login failed: ${error.message}";
      });
    } catch (e) {
      setState(() {
        errorMessage = "Oops, check your login data one more time.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // welcome text
              Text(
                "Welcome back",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 25),

              // email
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
                errorText: emailError,
              ),
              const SizedBox(height: 25),

              // password
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
                errorText: passwordError,
              ),
              const SizedBox(height: 25),

              // error message
              if (generalError != null)
                Text(
                  generalError!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 10),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              const SizedBox(height: 25),

              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // login
              MyButton(
                text: "Login",
                onTap: () => _validateAndLogin(),
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 25),

              // sign up
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

              // sign up with provider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProviderSignInTile(
                    onTap: () {},
                    imagePath: "../images/appleIcon.png",
                  ),
                  const SizedBox(width: 20),
                  ProviderSignInTile(
                    onTap: () => AuthService().signInWithGoogle(),
                    imagePath: "../images/googleIcon.png",
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // create an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
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
}
