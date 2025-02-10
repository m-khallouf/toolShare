import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class GetSelectedCategory {
  Future<List<Widget>> getSelectedCategory(String selectedCategory) async {
    List<Widget> offerWidgets = [];

    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Get firebase collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('category', isEqualTo: selectedCategory)
          .get();

      print("Found ${querySnapshot.docs.length} offers"); // Debug log

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        if(data['userId'] != user?.uid) {
          offerWidgets.add(
            DrawCurrentOfferContainer(
              title: data['title'] ?? 'Kein Titel',
              availability: data['availability'] != null
                  ? (data['availability'] as List<dynamic>).join(", ") : 'Nicht verfügbar',
              price: "${data['price'] ?? '0.00'} €",
              category: data['category'] ?? 'Unbekannte Kategorie',
              userIdInTheAd: data['userId'] ?? '',
            ),
          );
        }
      }
    } catch (e) {
      print("Fehler beim Abrufen der Angebote: $e");
    }

    return offerWidgets;
  }
}
