import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_profile.dart';

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

  Future<void> deleteAd(BuildContext context) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("Error: No user logged in!");
        return;
      }

      // Reference to Firestore collection
      CollectionReference offers = FirebaseFirestore.instance.collection('offers');

      // Query the document to find the specific ad based on userId and title
      QuerySnapshot querySnapshot = await offers
          .where('userId', isEqualTo: user.uid)
          .where('title', isEqualTo: title)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID
        String docId = querySnapshot.docs.first.id;

        // Delete the document from Firestore
        await offers.doc(docId).delete();

        print("Ad deleted successfully.");

        // Ensure we're still in a valid widget tree before navigating
        if (context.mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotEmptyAccountScreen()));
        }
      } else {
        print("Error: Ad not found!");
      }
    } catch (e) {
      print("Error deleting ad: $e");
    }
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
            onPressed: () async {
              await deleteAd(context);
            },
            child: const Text('Yes'),
          ),

        ],
      ),
    );
  }

}
