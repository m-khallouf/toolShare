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
    return SizedBox(
      width: 330,
      height: 50,
      child:  Align(
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: isValid ? Colors.green : Colors.red,
              ),
            ),

            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Password must be at least 8 characters long',
                  style: TextStyle(
                    color: Colors.black, fontSize: 14,
                  ),
                ) ,
              ),
            ),
          ],
        ),

      ),
    );




    /*Row(
      mainAxisAlignment: MainAxisAlignment.start, // Ensures text and circle align to the left
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
    );*/
  }
}
