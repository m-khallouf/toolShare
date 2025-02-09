import 'package:flutter/material.dart';
import 'package:tool_share/widget/my_button.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';

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

              MyButton(text: "publish an add", onTap: () => publishAdd(context)),
            ],
          ),
        ),
      ),
    );
  }

  void publishAdd(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PublishAdd()));
  }
}
