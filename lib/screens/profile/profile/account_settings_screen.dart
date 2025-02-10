import 'package:flutter/material.dart';

import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/utilities/export_all_profile.dart';
import 'package:tool_share/utilities/export_all_settings.dart';


class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page = const AccountSettingsHome(); // Default profile screen

        if (settings.name == '/settings') {
          page = const SettingsScreen();
        }

        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

class AccountSettingsHome extends StatelessWidget {
  const AccountSettingsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 300),
              SocialButton(imagePath: '../images/profileIcon.png', text: "Profile", onTap: () => account(context)),
              const SizedBox(height: 20),
              SocialButton(imagePath: '../images/settingsIcon.png', text: "Settings", onTap: () => Navigator.of(context).pushNamed('/settings')),
              const SizedBox(height: 20),
              SocialButton(imagePath: '../images/logoutIcon.png', text: "Log out", onTap: logout),
            ],
          ),
        ),
      ),
    );
  }

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  Future<void> account(BuildContext context) async {
    PublishedAdOrNot publishedAdOrNot = PublishedAdOrNot();
    bool hasOffers = await publishedAdOrNot.checkUserOffers();

    if (hasOffers) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotEmptyAccountScreen()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EmptyAccountScreen()));
    }
  }
}
