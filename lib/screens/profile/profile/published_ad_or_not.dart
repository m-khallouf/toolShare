import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'empty_account_screen.dart';
import 'not_empty_account.dart';

class PublishedAdOrNot {
  Future<void> checkUserOffersAndNavigate(BuildContext context) async {
    bool hasOffers = await checkUserOffers();

    if (hasOffers) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotEmptyAccountScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmptyAccountScreen()),
      );
    }
  }

  Future<bool> checkUserOffers() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user?.uid)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user offers: $e");
      return false; // Return false in case of an error
    }
  }
}
