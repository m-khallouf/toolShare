import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/home_screen.dart';
import '../widget/social_button.dart';
import 'sign_up_screen.dart';
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true; // To toggle password visibility

  static const double buttonHeight = 50.0;
  static const double buttonWidth = 330.0;

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
                  padding: EdgeInsets.only(top: 140.0),
                  child: Text('Welcome back!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(padding: EdgeInsets.only(top: 10.0), child: Text('Please enter your details'),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: 330,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: 330,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword ? Icons.visibility_off: Icons.visibility),
                                  onPressed: () { setState(() { _obscurePassword = !_obscurePassword; });},
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return value.length < 8 ? 'Password must be at least 8 characters long': null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login(context); // Pass context here
                              } else {
                                debugPrint('LOG: Form validation failed');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Login'),
                          ),
                        ),


                        const SizedBox(height: 20),

                        SocialButton(imagePath: 'images/appleIcon.png', text: 'Log in with Apple',
                          onPressed: () {
                            // TODO: Handle Apple login
                          },
                        ),
                        const SizedBox(height: 20),

                        SocialButton(imagePath: 'images/googleIcon.png', text: 'Log in with Google',
                          onPressed: () {
                            // TODO: Handle Google login
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the Sign Up screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

Future<void> login(BuildContext context) async {
  final auth = FirebaseAuth.instance;

  try {
    await auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    // Navigate to HomeScreen upon successful login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
    );
  } on FirebaseAuthException catch (e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        message = 'The email address is invalid.';
        break;
      default:
        message = 'An unexpected error occurred. Please try again.';
    }
    _showErrorDialog(context, message);
  } catch (e) {
    _showErrorDialog(context, 'An error occurred. Please try again later.');
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Login Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const DefaultTextStyle(
              style: TextStyle(color: Colors.black),
              child: Text('OK'),
            ),
            onPressed: () {
              Navigator.pop(context); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}