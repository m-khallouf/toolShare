import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class OfferService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Widget>> getOffers({String? category, bool onlyCurrentUser = false}) async {
    List<Widget> offerWidgets = [];

    try {
      User? user = _auth.currentUser;
      if (onlyCurrentUser && user == null) {
        print("Kein Benutzer angemeldet!");
        return [];
      }

      Query query = _firestore.collection('offers');

      // Apply category filter if provided
      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      // Apply user filter if fetching only the current user's offers
      if (onlyCurrentUser && user != null) {
        query = query.where('userId', isEqualTo: user.uid);
      }

      QuerySnapshot querySnapshot = await query.get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Skip offers from the current user (unless fetching the user's offers)
        if (!onlyCurrentUser && data['userId'] == user?.uid) continue;

        offerWidgets.add(
          DrawCurrentOfferContainer(
            title: data['title'] ?? 'Kein Titel',
            availability: data['availability'] != null
                ? (data['availability'] as List<dynamic>).join(", ")
                : 'Nicht verfügbar',
            price: "${data['price'] ?? '0.00'} €",
            category: data['category'] ?? 'Unbekannte Kategorie',
            userIdInTheAd: data['userId'] ?? '',
          ),
        );
      }
    } catch (e) {
      print("Fehler beim Abrufen der Angebote: $e");
    }

    return offerWidgets;
  }
}
