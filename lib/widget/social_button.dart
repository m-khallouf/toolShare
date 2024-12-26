import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  static const boxWidth = 330.0;
  static const boxHeight = 50.0;
  static const borderRadius = 8.0;
  static const imageWidth = 24.0;
  static const imageHeight = 24.0;

  const SocialButton({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: boxWidth, height: boxHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white38,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: imageWidth, height: imageHeight),
              const SizedBox(width: 10),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}