import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tool_share/utilities/export_all_chat.dart';

import 'open_chat_room2.dart'; // Import your chat screen

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatRooms')
            .where('users', arrayContains: FirebaseAuth.instance.currentUser !.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chatRooms = snapshot.data!.docs;

          if (chatRooms.isEmpty) {
            return const Center(child: Text('No messages yet.'));
          }

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final chatRoomId = chatRoom.id;
              final users = chatRoom['users'] as List<dynamic>;
              final otherUserId = users.firstWhere((userId) => userId != FirebaseAuth.instance.currentUser!.uid);

              return ListTile(
                title: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                    child: Text('Chat with $otherUserId', textAlign: TextAlign.center,),
                ),
                // subtitle: Text('Last message: ${chatRoom['lastMessage'] ?? 'No messages yet.'}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpenChatRoom2(
                        adTitle: 'Chat with $otherUserId', // You can customize this
                        receiverId: otherUserId,
                        chatRoomId: chatRoomId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}