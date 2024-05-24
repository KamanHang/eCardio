import 'package:ecardio/view/LoginPage.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Profile Page'),
            ElevatedButton(
              onPressed: () {
                // Perform logout action
                _logout();
              },
              child: Text('Log Out'),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform logout action
                _schedule();
              },
              child: Text('Notification'),
            ),
          ],
        ),
      ),
    );
  }

    void _schedule() {
    // Clear any user authentication data or tokens here

    // Navigate back to the login page
  }

  void _logout() {
    // Clear any user authentication data or tokens here

    // Navigate back to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // This will remove all routes from the stack
    );
  }
}
