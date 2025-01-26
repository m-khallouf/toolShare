import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tool_share/screens/home_screen.dart';
import 'package:tool_share/screens/add_screen.dart';
import 'package:tool_share/screens/setting_screen.dart';


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
    const AddScreen(),
    const SettingScreen(),
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
        backgroundColor: Colors.grey, // Black background for the nav bar
        currentIndex: _selectedIndex, // Highlight the selected tab
        onTap: _onItemTapped, // Handle tab changes
        showSelectedLabels: false, // Hide text labels
        showUnselectedLabels: false, // Hide text labels for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/homeIcon.png', width: 25, height: 25,),// Search icon
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/addIcon.png', width: 25, height: 25),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/profileIcon.png', width: 25, height: 25),
            label: '', // No label
          ),
        ],
      ),
    );
  }
}
