import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_auth.dart';
import 'package:tool_share/utilities/export_all_widget.dart';

import '../../services/chat/chat_service.dart';

class OpenChatRoom2 extends StatelessWidget {
  final String adTitle;
  final String receiverId;
  final String chatRoomId;

  const OpenChatRoom2({
    Key? key,
    required this.adTitle,
    required this.receiverId,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adTitle),
      ),
      body: ChatScreen(chatRoomId: chatRoomId),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String chatRoomId;

  const ChatScreen({Key? key, required this.chatRoomId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? currentUser ;

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    currentUser  = _auth.currentUser ;
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('chatRooms').doc(widget.chatRoomId).collection('messages').add({
        'senderId': currentUser!.uid,
        'receiverId': widget.chatRoomId.split('_').last, // Extract receiver ID from chatRoomId
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser  = data["senderId"] == currentUser !.uid;

    return Container(
      alignment: isCurrentUser  ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: isCurrentUser  ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrentUser  ? Colors.green[500] : Theme.of(context).colorScheme.secondary, // Different color for received messages
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              data["message"],
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data["senderId"] == currentUser !.uid ? 'You' : 'User  ${data["senderId"]}',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('chatRooms').doc(widget.chatRoomId).collection('messages').orderBy('timestamp').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              final messages = snapshot.data!.docs;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(messages[index]);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: MyTextField(hintText: "type a message...", obscureText: false, controller: _messageController, width: 0,),
              ),
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green[500],
                  ),
                  child: Icon(
                      Icons.arrow_upward,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                onPressed: sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}