import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tool_share/themes/theme_provider.dart';

import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Mode"),
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                  ),
                ],
              ),
            ),

            SocialButton(imagePath: '../images/logoutIcon.png', text: "Log out", onTap: AuthService().signOut),
          ],
        ),
      ),
    );
  }
}
