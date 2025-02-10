import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double height;
  final String text;

  const MyContainer({
    super.key,
    required this.height,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(horizontal: 25),

      child: Center(
        child: Text(text),
      ),
    );
  }
}
