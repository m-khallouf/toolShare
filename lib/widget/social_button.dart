import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;

  static const boxWidth = 330.0;
  static const boxHeight = 50.0;
  static const borderRadius = 8.0;
  static const imageWidth = 24.0;
  static const imageHeight = 24.0;

  const SocialButton({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),

        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: imageWidth, height: imageHeight),
            const SizedBox(width: 10),
            Text(text)
          ],
        ),
      ),
    );
  }
}