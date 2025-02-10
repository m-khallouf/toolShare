import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/widget/draw_current_offer_container.dart';
import 'package:tool_share/widget/my_button.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';
import 'package:tool_share/widget/my_container.dart';

import '../../../services/offers/get_user_offers.dart';

class NotEmptyAccountScreen extends StatelessWidget {
  const NotEmptyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User information
              MyContainer(height: 200, text: "user information"),
              const SizedBox(height: 25),

              // Current offers
              /*Container(
                width: 360,
                height: 400, // Fixed height for the container
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView( // Make the content scrollable
                  child: Column(
                    children: [
                      Future<void>getCurrentOffers();
                    ],
                  ),
                ),*/

              Container(
                width: 360,
                height: 400, // Feste Höhe für den Container
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<List<Widget>>(
                  future: GetUserOffers().getCurrentOffers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text("Fehler beim Laden der Angebote"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Keine Angebote verfügbar"));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!,
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              // Create new ad
              MyButton(
                text: "Publish an ad",
                onTap: () => publishAdd(context),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void publishAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PublishAdd()),
    );
  }

  /*Future<List<Widget>>getCurrentOffers() async{
    try{
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId', isEqualTo: user?.uid)
          .get();



      for () {
        DrawCurrentOfferContainer(title: '', availability: '', price: '', category: '', )
      }
    } catch (e) {
      print("error");
    }
  }*/

}
