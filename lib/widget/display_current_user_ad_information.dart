import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/widget/my_button.dart';
import 'package:tool_share/widget/my_container.dart';

class DisplayCurrentUserAdInformation extends StatelessWidget {
  /*
  final String description;
  final Map<String, dynamic> availability;
  final String category;
  final int price;
  final String userId;*/

  const DisplayCurrentUserAdInformation({
    super.key, /*
    required this.description,
    required this.availability,
    required this.category,
    required this.price,
    required this.userId,*/
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image
              Container(
                width: double.infinity,
                height: 230,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  border: Border.all(
                      width: 1, color: Theme
                      .of(context)
                      .colorScheme
                      .tertiary),
                  borderRadius: BorderRadius.circular(8),
                ),

                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Icon(Icons.image, size: 50, color: Colors.black),
              ),

              const SizedBox(height: 25),

              // description
              MyContainer(height: 50, text: "get description"),

              const SizedBox(height: 25),

              // availability
              MyContainer(height: 50, text: "get availability"),

              const SizedBox(height: 25),

              // price
              MyContainer(height: 50, text: "getPrice"),

              const SizedBox(height: 25),

              // category
              MyContainer(height: 50, text: "get category"),

              const SizedBox(height: 25),

              // send message button
              MyButton(text: "edit", onTap: openChatRoomWithUser, color: Theme
                  .of(context)
                  .colorScheme
                  .secondary,),

              const SizedBox(height: 25),

              // delete ad
              MyButton(text: "delete",
                onTap: () => _showAlertDialog(context),
                color: Colors.red.shade900,),

            ],
          ),
        ),
      ),
    );
  }

  void openChatRoomWithUser() {
  }

  void delelteAd() {
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to delete the AD?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              delelteAd();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
