import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
        ));
  }
}
