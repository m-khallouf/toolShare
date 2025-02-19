import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_offers.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  late Future<List<Widget>> offersFuture;

  // offer service
  final OfferService _offerService = OfferService();

  @override
  void initState() {
    super.initState();
    offersFuture = _offerService.getOffers(); // Load all offers initially
  }

  // Function to filter offers by category
  void filterOffers(String category) {
    setState(() {
      selectedCategory = category;
      offersFuture = _offerService.getOffers(category: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Theme.of(context).colorScheme.secondary,
                            width: double.infinity,
                            height: 30,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Explore popular categories',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                            ),
                          ),

                          /// Icons Row
                          Container(
                            color: Theme.of(context).colorScheme.secondary,

                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    List<Widget> offers = await OfferService().getOffers(category: "General tools");
                                    setState(() {
                                      offersFuture = Future.value(offers);
                                    });
                                  },
                                  child: CategoryIcon(assetPath: 'images/tools.png'),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    List<Widget> offers = await OfferService().getOffers(category: "Household tools");
                                    setState(() {
                                      offersFuture = Future.value(offers);
                                    });
                                  },
                                  child: CategoryIcon(assetPath: 'images/houseIcon.png'),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    List<Widget> offers = await OfferService().getOffers(category: "Garden tools");
                                    setState(() {
                                      offersFuture = Future.value(offers);
                                    });
                                  },
                                  child: CategoryIcon(assetPath: 'images/gardenIcon.png'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          /// Display Offers
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 250, // Minimum height of 250
                              maxHeight: 500, // Maximum height of 500
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              child: FutureBuilder<List<Widget>>(
                                future: offersFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(child: Text("Error loading offers"));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Center(child: Text("No offers available"));
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Search Box
            Positioned(
              top: 20,
              left: 27,
              right: 27,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
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
                          fillColor: Theme.of(context).colorScheme.inversePrimary
                        ),
                        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
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
