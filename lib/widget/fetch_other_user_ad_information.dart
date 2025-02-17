import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/screens/home/home_screen.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_chat.dart';

import '../screens/chat/open_chat_room2.dart';
import '../screens/navbar_screen.dart';

class DisplayOtherUserAdInformation extends StatelessWidget {
  final String title;
  final String availability;
  final String category;
  final String price;
  final String userIdInTheAd;

  const DisplayOtherUserAdInformation({
    super.key,
    required this.title,
    required this.availability,
    required this.category,
    required this.price,
    required this.userIdInTheAd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Placeholder
              Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const Icon(Icons.image, size: 50, color: Colors.black),
              ),
              const SizedBox(height: 25),

              // title
              MyContainer(height: 50, text: title),
              const SizedBox(height: 25),

              // Availability
              MyContainer(height: 50, text: availability),
              const SizedBox(height: 25),

              // price
              MyContainer(height: 50, text: price),
              const SizedBox(height: 25),

              // category
              MyContainer(height: 50, text: category),
              const SizedBox(height: 25),

              // send message button showSuccessDialog(context)
              MyButton(
                text: "send message",
                onTap: () => createChatRoom(context),
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showCupertinoDialog(context: context,builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('New chatroom was created'),
          content: Text('Check the messages to be able to contact the user!'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                print("OK pressed"); // Debugging statement
                Navigator.of(context).pop(); // Close the dialog
                // Navigate to MessagesScreen or update the BottomNavBar here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                );
              },
            ),
          ],
        );
      });

  }

  void createChatRoom(BuildContext context) async {
    User? currentUser  = FirebaseAuth.instance.currentUser ;

    if (currentUser  == null) {
      print("Error: No user logged in!");
      return;
    }

    // Create a unique chat room ID
    String chatRoomId = "${currentUser.uid}_$userIdInTheAd";

    // Create a chat room document in Firestore
    await FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).set({
      'users': [currentUser.uid, userIdInTheAd],
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
    });

    // Navigate to the chat screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpenChatRoom2(adTitle: title, receiverId: userIdInTheAd, chatRoomId: chatRoomId),
      ),
    );
  }

}
