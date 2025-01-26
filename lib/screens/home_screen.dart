import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView( // Use SingleChildScrollView to make it scrollable if needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120), // Space for the fixed search box
                 Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 330,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 1, // Border width
                        ),
                      ),
                      child: const Text(
                          'Explore popular categories',
                          textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Image.asset(
                              'images/tools.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Image.asset(
                              'images/tools.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Image.asset(
                              'images/tools.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Image.asset(
                              'images/tools.png',
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Align(
                  child: Container(
                    width: 330, height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                width: 330,
                height: 50,
                decoration: BoxDecoration(
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
                        Icons.search,
                        color: Colors.grey,
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
        ],
      ),
    );
  }
}
