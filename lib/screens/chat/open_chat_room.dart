import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/services/authentication/auth_service.dart';
import 'package:tool_share/services/chat/chat_service.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

class OpenChatRoom extends StatelessWidget {
  final String adTitle;
  final String receiverId;

  OpenChatRoom({super.key, required this.adTitle, required this.receiverId});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty && receiverId != null) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      // clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(adTitle),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }

        // return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == _authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(alignment:alignment, child: Text(data["message"]));
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            hintText: "type a message",
            obscureText: false,
            controller: _messageController,
          ),
        ),
        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward)),
      ],
    );
  }
}
