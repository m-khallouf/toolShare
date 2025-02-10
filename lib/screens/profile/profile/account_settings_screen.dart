import 'package:flutter/material.dart';
import 'package:tool_share/screens/profile/profile/empty_account_screen.dart';
import 'package:tool_share/screens/profile/profile/not_empty_account.dart';
import 'package:tool_share/screens/profile/profile/published_ad_or_not.dart';
import 'package:tool_share/screens/profile/settings/settings_screen.dart';
import 'package:tool_share/services/authentication/auth_service.dart';

import 'package:tool_share/utilities/export_all_widget.dart';


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
