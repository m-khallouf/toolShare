import 'package:flutter/material.dart';

import '../services/security/sql_injection.dart';
import 'package:tool_share/services/security/injections.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? errorText;


  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.errorText,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}


class _MyTextFieldState extends State<MyTextField> {
  String? errorText;

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

  void _validateInput() {
    setState(() {
      // Reset error text
      errorText = null;
    });

    String input = widget.controller.text;


    if (_isSQLInjectionAttempt(input)) {
      _showInjectionScreen(context);
      setState(() {
        errorText = "Invalid input detected. Please avoid SQL keywords.";
      });
    } else if (input.isEmpty) {
      setState(() {
        errorText = "This field cannot be empty.";
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        onChanged: (_) => _validateInput(), // Trigger validation on text change

        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.errorText == null ? Theme.of(context).colorScheme.tertiary : Colors.red.shade900,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          errorText: widget.errorText,
        ),
      ),
    );
  }

  void _showInjectionScreen(BuildContext context) {

    print("SQL Injection detected, navigating to injection screen...");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InjectionDetectedScreen()),
    );
  }
}