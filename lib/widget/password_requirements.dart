import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final bool isValid;
  final String text;

  const PasswordRequirements({
    Key? key,
    required this.isValid,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isValid ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
