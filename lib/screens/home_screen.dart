import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of widgets for each tab
  static final List<Widget> _pages = [

    Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding:  const EdgeInsets.only(top: 50),
        child: Container(
          width: 330,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white, // Background color (optional)
            border: Border.all(
              color: Colors.black, // Border color
              width: 2, // Border width
            ),
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.search, color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),


    const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(fontSize: 24),
      ),
    ),
    const Center(
      child: Text(
        'Add Screen',
        style: TextStyle(fontSize: 24),
      ),
    ),
    const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    ),
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
            icon: Image.asset('images/homeIcon.png', width: 25, height: 25,
            ),// Search icon
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
