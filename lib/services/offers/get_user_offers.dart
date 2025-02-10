import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class GetUserOffers {

  Future<List<Widget>> getCurrentOffers() async {
    List<Widget> offerWidgets = [];

    try {
      // get current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("Kein Benutzer angemeldet!");
        return [];
      }

      // get firestore collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Angebot-Container erstellen und zur Liste hinzufügen
        offerWidgets.add(DrawCurrentOfferContainer(
          title: data['title'] ?? 'Kein Titel',
          availability: (data['availability'] as List<dynamic>).join(", ") ??
              'Nicht verfügbar',
          price: "${data['price'] ?? '0.00'} €",
          category: data['category'] ?? 'Unbekannte Kategorie',
          userIdInTheAd: user.uid,
        ));
      }
    } catch (e) {
      print("Fehler beim Abrufen der Angebote: $e");
    }

    return offerWidgets;
  }
}