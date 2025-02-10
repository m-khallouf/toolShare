import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PublishedAdOrNot {
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
