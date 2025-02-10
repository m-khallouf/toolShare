import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_widget.dart';
import 'package:tool_share/utilities/export_all_profile.dart';

class EmptyAccountScreen extends StatelessWidget {
  const EmptyAccountScreen({super.key});

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

              MyButton(text: "publish an add", onTap: () => publishAdd(context), color: Theme.of(context).colorScheme.secondary,),
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
