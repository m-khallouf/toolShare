import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tool_share/utilities/export_all_widget.dart';

class DrawCurrentOfferContainer extends StatelessWidget {
  final String title;
  final String availability;
  final String price;
  final String category;
  final String userIdInTheAd;

  const DrawCurrentOfferContainer({
    super.key,
    required this.title,
    required this.availability,
    required this.price,
    required this.category,
    required this.userIdInTheAd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.tertiary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image, size: 50, color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 150, height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16),),
                  Text(availability, style: TextStyle(fontSize: 16),),
                  Text(price, style: TextStyle(fontSize: 16),),
                  Text(category, style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the current user is the same as the user in the ad
    if (currentUser?.uid == userIdInTheAd) {
      // Navigate to DisplayCurrentUserAdInformation screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayCurrentUserAdInformation()),
      );
    } else {
      // Navigate to DisplayOtherUserAdInformation screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplayOtherUserAdInformation()),
      );
    }
  }

}