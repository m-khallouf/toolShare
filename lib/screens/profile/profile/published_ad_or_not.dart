import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/login_signup/sign_up_screen.dart';
import 'package:tool_share/screens/login_signup/login_screen.dart';
import 'package:tool_share/screens/profile/profile/empty_account_screen.dart';
import 'package:tool_share/screens/profile/profile/not_empty_account.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';

class PublishedAdOrNot {
/*
  Future<bool> checkUserOffers() async {

    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Query Firestore for offers by the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user?.uid) // Ensure the userId field exists in Firestore
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        /*
        print("User has published the following offers:");
        for (var doc in querySnapshot.docs) {
          print("Offer ID: ${doc.id}, Data: ${doc.data()}");
        }*/
        NotEmptyAccountScreen();
      } else {
        EmptyAccountScreen();
        print("no offers found"); // No offers found
      }
    } catch (e) {
      print("Error checking user offers: $e");
    }
  }*/

    Future<bool> checkUserOffers() async {
      try {
        User? user = FirebaseAuth.instance.currentUser ;

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
