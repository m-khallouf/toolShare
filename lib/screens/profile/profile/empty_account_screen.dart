import 'package:flutter/material.dart';
import 'package:tool_share/widget/my_button.dart';
import 'package:tool_share/screens/profile/profile/publish_add.dart';

class EmptyAccountScreen extends StatelessWidget {
  const EmptyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oooops, it looks empty in here!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 25),

              Image.asset("../images/emptyIllustration.png"),

              const SizedBox(height: 25),

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
