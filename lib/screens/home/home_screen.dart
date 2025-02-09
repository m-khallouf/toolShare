import 'package:flutter/material.dart';
import 'package:tool_share/themes/light_mode.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            /// Scrollable Content
            Positioned.fill(
              child: Column(
                children: [
                  const SizedBox(height: 150), // Space for search box
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Categories Section
                          Container(
                            width: 330,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Border color
                              ),
                            ),
                            child: const Text(
                              'Explore popular categories',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// Icons Row
                          SizedBox(
                            width: 330,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                4,
                                    (index) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Image.asset(
                                      'images/tools.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          /// Scrollable Content
                          Container(
                            width: 330,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            /*
                            child: Column(
                              children: List.generate(
                                20, // Dummy items for scroll effect
                                    (index) => Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("Item ${index + 1}")),
                                  ),
                                ),
                              ),
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Search Box (Floating Above)
            Positioned(
              top: 70,
              left: 40,
              right: 40,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
          ],
        ),
      ),
    );
  }
}
