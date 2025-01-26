import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/navbar_screen.dart';
import '../widget/social_button.dart';
import 'sign_up_screen.dart';
import 'package:tool_share/screens/sql_injection.dart';

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
                                if (_isSQLInjectionAttempt(_emailController.text) || _isSQLInjectionAttempt(_passwordController.text)) {
                                  _showInjectionScreen(context);
                                } else {
                                  login(context); // Normal login if no SQL Injection
                                }
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

bool _isSQLInjectionAttempt(String input) {
  // List of common SQL injection phrases
  List<String> sqlInjectionPatterns = [
    "' OR '1'='1",
    "' OR '1'='1' --",
    "' OR 1=1 --",
    "' UNION SELECT NULL, username, password FROM users --",
    "' UNION SELECT NULL, NULL, NULL --",
    "' AND 1=1 --",
    "' AND 1=1#",
    "' AND 'a'='a",
    "' OR EXISTS(SELECT * FROM users WHERE 'a'='a') --",
    "' OR 'a'='a' --",
    "' AND 1=2 --",
    "' OR 'x'='x",
    "' OR 'x'='x' --",
    "' AND 1=1#",
    "' AND 1=1/*",
    "' DROP TABLE users --",
    "' OR 1=1; --",
    "' UNION SELECT null, null, username, password FROM users --",
    "' HAVING 1=1 --",
    "' SELECT * FROM users WHERE 'a'='a' --",
    "' SELECT user(), version() --",
    "' SELECT @@version --",
    "' SELECT table_name FROM information_schema.tables --",
    "' SELECT column_name FROM information_schema.columns WHERE table_name = 'users' --",
    "' AND ASCII(substring(@@version,1,1))>51 --",
    "' UNION SELECT null, null, null, null, group_concat(table_name) FROM information_schema.tables --",
    "' AND sleep(5) --",
    "' UNION SELECT null, null, load_file('/etc/passwd') --",
    "' AND 1=1 -- WAITFOR DELAY '0:0:5' --",
    "' EXEC xp_cmdshell('dir') --",
    "' OR IF(1=1, SLEEP(5), 0) --",
    "' AND IF(1=1, SLEEP(5), 0) --",
    "' OR 1=1; WAITFOR DELAY '0:0:10' --",
    "' AND 1=1; WAITFOR DELAY '0:0:10' --",
    "' AND sleep(10) --",
    "' AND 1=1 -- -",
    "' OR 1=1 -- -",
    "' ORDER BY 1--",
    "' ORDER BY 2--",
    "' GROUP BY column_name HAVING 1=1 --",
    "' SELECT * FROM non_existent_table --",
    "' UNION SELECT NULL, NULL, NULL --",
    "' UNION SELECT 1, username, password FROM users --",
    "' UNION SELECT null, database(), user(), version() --",
    "' UNION SELECT null, null, load_file('/etc/passwd') --",
    "' UNION SELECT table_name FROM information_schema.tables --",
    "' OR 1=1 --",
    "' OR '' = '' --",
    "' OR 'a' = 'a' --",
    "' AND 1=1#",
    "' AND 'a'='a' --",
    "' OR '1'='1'; DROP TABLE users --",
    "'/ (comment)**",
    "' ; --",
    "' ; EXEC xp_cmdshell('ping 127.0.0.1') --",
    "' --",
    "' / --*",
    "' SELECT * FROM customers WHERE id = '' OR 1=1 --"
  ];

  for (var pattern in sqlInjectionPatterns) {
    if (input.contains(pattern)) {
      return true;
    }
  }
  return false;
}


void _showInjectionScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const InjectionDetectedScreen()),
  );
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
      MaterialPageRoute(builder: (context) =>  BottomNavBar()),
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