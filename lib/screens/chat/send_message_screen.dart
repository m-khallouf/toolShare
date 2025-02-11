import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class SendMessageScreen extends StatelessWidget {
  SendMessageScreen({super.key});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // Use a PreferredSize widget to customize the AppBar
        title: const Text(""),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // receiver info
              MyContainer(height: 200, text: "receiver info"),
              const SizedBox(height: 25),

              // message box
              MyTextField(
                hintText: "send a friendly message",
                obscureText: false,
                controller: _messageController,
              ),
              const SizedBox(height: 300),

              MyButton(text: "send", onTap: createChatRoomRec, color: Theme.of(context).colorScheme.secondary,),

            ],
          ),
        ),
      ),
    );
  }

  void createChatRoomRec() {
  }
}
