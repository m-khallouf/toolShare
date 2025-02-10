import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String assetPath;

  const CategoryIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Image.asset(assetPath, width: 25, height: 25),
    );
  }
}