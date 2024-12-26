import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true; // To toggle password visibility

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 140.0),
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Please enter your details',
                  ),
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
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
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
                                  icon: Icon(_obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 330,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login Successful'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white38,
                              foregroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/google.png', width: 24, height: 24),
                                const SizedBox(width: 10),
                                const Text('Log in with Google'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white38,
                              foregroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/apple.png', width: 24, height: 24),
                                const SizedBox(width: 10),
                                const Text('Log in with Apple'),
                              ],
                            ),
                          ),
                        ),
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
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the Sign Up screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
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
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text('Sign Up Screen'),
      ),
    );
  }
}
