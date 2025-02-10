import 'package:flutter/material.dart';
import 'package:tool_share/screens/home/home_screen.dart';
import 'package:tool_share/screens/chat/messages_screen.dart';
import 'package:tool_share/screens/profile/profile/account_settings_screen.dart';
import 'package:tool_share/screens/profile/settings/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // List of widgets for each tab
  static final List<Widget> _pages = [
    const HomeScreen(),
    const MessagesScreen(),
    const AccountSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary, // Black background for the nav bar
        currentIndex: _selectedIndex, // Highlight the selected tab
        onTap: _onItemTapped, // Handle tab changes
        showSelectedLabels: false, // Hide text labels
        showUnselectedLabels: false, // Hide text labels for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/homeIcon.png', width: 25, height: 25,), // Home icon
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/messageIcon.png', width: 25, height: 25), // Message icon
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/profileIcon.png', width: 25, height: 25), // Profile icon
            label: '', // No label
          ),
        ],
      ),
    );
  }
}
