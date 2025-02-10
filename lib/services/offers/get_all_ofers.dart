import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class GetAllOffers {

  Future<List<Widget>> getAllOffers() async {
    List<Widget> offerWidgets = [];

    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      // get firebase collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .get(); // Get all offers without filtering by userId

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        if(data['userId'] != user?.uid) {
          // draw offers & add to the list
          offerWidgets.add(DrawCurrentOfferContainer(
            title: data['title'] ?? 'Kein Titel',
            availability: (data['availability'] as List<dynamic>).join(", ") ??
                'Nicht verfügbar',
            price: "${data['price'] ?? '0.00'} €",
            category: data['category'] ?? 'Unbekannte Kategorie',
            userIdInTheAd: '',
          ));
        }
      }
    } catch (e) {
      print("Fehler beim Abrufen der Angebote: $e");
    }

    return offerWidgets;
  }
}