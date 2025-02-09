import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/login_signup/sign_up_screen.dart';
import 'package:tool_share/screens/login_signup/login_screen.dart';

class PublishedAdOrNot {

  Future<void> checkUserOffers() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("No user is logged in.");
        return;
      }

      // Query Firestore for offers by the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user.uid) // Ensure the userId field exists in Firestore
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("User has published the following offers:");
        for (var doc in querySnapshot.docs) {
          print("Offer ID: ${doc.id}, Data: ${doc.data()}");
        }
      } else {
        print("false"); // No offers found
      }
    } catch (e) {
      print("Error checking user offers: $e");
    }
  }

}
