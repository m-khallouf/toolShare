import 'package:flutter/material.dart';
import 'package:tool_share/themes/light_mode.dart';

class ProviderSignInTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;

  const ProviderSignInTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Image.asset(
          imagePath
        ),
      ),
    );
  }
}