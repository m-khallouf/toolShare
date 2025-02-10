import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tool_share/utilities/export_all_profile.dart';

class SubmitOffer {
  final TextEditingController titleController;
  final TextEditingController priceController;
  final int selectedCategory;
  final List<String> categories;
  final Map<String, bool> availabilitySelected;
  final Function() onUpdate;

  const SubmitOffer({
    required this.titleController,
    required this.priceController,
    required this.selectedCategory,
    required this.categories,
    required this.availabilitySelected,
    required this.onUpdate,
  });


  void submit(BuildContext context) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      print("Current User: ${user?.uid ?? 'No user logged in'}");

      // Reference to Firestore
      CollectionReference offers = FirebaseFirestore.instance.collection('offers');

      // Data to be uploaded
      Map<String, dynamic> offerData = {
        'title': titleController.text,
        'price': double.tryParse(priceController.text) ?? 0.0,
        'category': selectedCategory >= 0 ? categories[selectedCategory] : '',
        'availability': availabilitySelected.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        'userId': user?.uid, // Ensure this is correct
      };

      print("Uploading data: $offerData");

      // Save data to Firestore
      await offers.add(offerData);


      // Success message
      print("Offer submitted by user: ${user?.uid}");

      // Clear fields after successful submission
      titleController.clear();
      priceController.clear();

      // Call the onUpdate callback to trigger setState
      onUpdate();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotEmptyAccountScreen()),
      );

    } catch (e) {
      print("Error submitting offer: $e");
    }
  }

}