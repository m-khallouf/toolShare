import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/themes/light_mode.dart';
import 'package:tool_share/widget/my_container.dart';

import '../../services/offers/get_all_ofers.dart';
import '../../widget/draw_current_offer_container.dart';

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
                  const SizedBox(height: 130), // Space for search box
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Categories Section
                          Container(
                            width: double.infinity,
                            height: 30,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: const Text(
                              'Explore popular categories',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// Icons Row
                          SizedBox(
                            width: double.infinity,
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

                          const SizedBox(height: 15),

                          /// Scrollable Content
                          Container(
                            width: double.infinity, height: 550,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.secondary,
                            ),

                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 25),

                            child: FutureBuilder<List<Widget>>(
                              future: GetAllOffers().getAllOffers(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Fehler beim Laden der Angebote"));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text("Keine Angebote verfügbar"));
                                } else {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: snapshot.data!,
                                    ),
                                  );
                                }
                              },
                            ),
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
              left: 27,
              right: 27,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondary,
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
