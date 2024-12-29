import 'package:flutter/material.dart';
import '../widget/password_requirements.dart';


class CreateAnAccountScreen extends StatefulWidget {
  const CreateAnAccountScreen({super.key});

  @override
  _CreateAnAccountScreenState createState() => _CreateAnAccountScreenState();
}

class _CreateAnAccountScreenState extends State<CreateAnAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Password requirement flags
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _hasUpperCase = false;

  // Method to validate password
  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasNumber = RegExp(r'\d').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      _hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    });
  }

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
                  child: Text('Create an Account', style: TextStyle(fontSize: 30)),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: 330,
                            height: 50,
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
                            width: 330, height: 50,
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
                              onChanged: _validatePassword, // Call validator on text change
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRequirements(
                                isValid: _hasMinLength,
                                text: 'Password must be at least 8 characters long',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRequirements(
                                isValid: _hasNumber,
                                text: 'Password must include a number',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRequirements(
                                isValid: _hasSpecialChar,
                                text: 'Password must include a special character',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PasswordRequirements(
                                isValid: _hasUpperCase,
                                text: 'Password must include an uppercase letter',
                              ),
                            ],
                          ),
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
