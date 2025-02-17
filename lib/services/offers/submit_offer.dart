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
  final Function(String) onUpdate;

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

      if (user == null) {
        print("Error: No user logged in! Cannot submit.");
        return;
      }

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
        'userId': user.uid,
      };

      print("Uploading data: $offerData");

      // Save data to Firestore and get the document reference
      DocumentReference docRef = await offers.add(offerData);

      // Save data to Firestore
      //await offers.add(offerData);

      // Get the unique ID of the newly created document
      String uniqueId = docRef.id;

      // Success message
      print("Offer submitted by user: ${user.uid}");

      // Clear fields after successful submission
      titleController.clear();
      priceController.clear();

      // Call the onUpdate callback to trigger setState
      onUpdate(uniqueId);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotEmptyAccountScreen()),
      );

    } catch (e) {
      print("Error submitting offer: $e");
    }
  }
}