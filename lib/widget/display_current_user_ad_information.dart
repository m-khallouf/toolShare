import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tool_share/utilities/export_all_widget.dart';

class DisplayCurrentUserAdInformation extends StatelessWidget {
  final String title;
  final String availability;
  final String category;
  final String price;
  final String userIdInTheAd;

  const DisplayCurrentUserAdInformation({
    super.key,
    required this.title,
    required this.availability,
    required this.category,
    required this.price,
    required this.userIdInTheAd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Ad Information"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Placeholder
              Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Icon(Icons.image, size: 50, color: Colors.black),
              ),
              const SizedBox(height: 25),

              // title
              MyContainer(height: 50, text: title),
              const SizedBox(height: 25),

              // Availability
              MyContainer(height: 50, text: availability),
              const SizedBox(height: 25),

              // Price
              MyContainer(height: 50, text: price),
              const SizedBox(height: 25),

              // Category
              MyContainer(height: 50, text: category),
              const SizedBox(height: 25),

              // Edit Ad Button
              MyButton(
                text: "Edit",
                onTap: () => editAd(),
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 25),

              // Delete Ad Button
              MyButton(
                text: "Delete",
                onTap: () => _showAlertDialog(context),
                color: Colors.red.shade900,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editAd() {
    // Implement your edit logic here
  }

  void deleteAd() {
    // Implement delete logic here
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to delete the AD?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              deleteAd();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> displayUserAdEditOrDelete() async {
    List<Widget> offerWidgets = [];
    try {
      // Get Current User
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("No user logged in!");
        return [];
      }

      // Get Firestore collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Create Ad container and add to list
        offerWidgets.add(DisplayCurrentUserAdInformation(
          title: data['title'],
          availability: (data['availability'] as List<dynamic>).join(", "),
          price: "${data['price']} €",
          category: data['category'],
          userIdInTheAd: user.uid,
        ));
      }
    } catch (e) {
      print("Error fetching ads: $e");
    }

    return offerWidgets;
  }
}
