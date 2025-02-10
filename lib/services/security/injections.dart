import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Injections {

  final storage = FlutterSecureStorage();

// Function to log out user and ban them
  Future<void> logoutAndBan(String userEmail) async {
    // Clear session or token
    await storage.delete(key: 'auth_token');
    await storage.write(key: 'banned_user', value: userEmail);  // Simulating the ban in storage
  }

// Function to check if the user is banned
  Future<bool> isUserBanned(String userEmail) async {
    String? bannedUserEmail = await storage.read(key: 'banned_user');
    return bannedUserEmail == userEmail;
  }
}