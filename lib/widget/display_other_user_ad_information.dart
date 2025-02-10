import 'package:flutter/material.dart';
import 'package:tool_share/widget/my_button.dart';

class DisplayOtherUserAdInformation extends StatelessWidget {
  /*
  final String description;
  final Map<String, dynamic> availability;
  final String category;
  final int price;
  final String userId;*/

  const DisplayOtherUserAdInformation({
    super.key,/*
    required this.description,
    required this.availability,
    required this.category,
    required this.price,
    required this.userId,*/
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Container(
                width: 360,
                height: 230,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.image, size: 50, color: Colors.black),
              ),

              const SizedBox(height: 25),

              // description
              Container(
                width: 360, height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("get description"),
              ),

              const SizedBox(height: 25),

              // availability
              Container(
                width: 360, height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("get availability"),
              ),

              const SizedBox(height: 25),

              // price
              Container(
                width: 360, height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("get price"),
              ),

              const SizedBox(height: 25),

              // category
              Container(
                width: 360, height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("get category"),
              ),

              const SizedBox(height: 25),
              
              // send message button
              MyButton(text: "send message", onTap: openChatRoomWithUser, color: Theme.of(context).colorScheme.secondary,)
            ],
          ),
        ),
      ),
    );
  }

  void openChatRoomWithUser() {
  }
}
