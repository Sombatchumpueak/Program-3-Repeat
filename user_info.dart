import 'package:flutter/material.dart';
import '../models/users.dart';

class UserInfo extends StatelessWidget {
  final Users user;

  const UserInfo({required this.user, Key? key}) : super(key: key);

  Widget buildInfoText(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 243, 33, 33),
        iconTheme: IconThemeData(color: Colors.white),  // Set back arrow color to white
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),  // Set title color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoText('Full Name', user.fullname ?? ''),
            buildInfoText('Email', user.email ?? ''),
            buildInfoText('Gender', user.gender ?? ''),
          ],
        ),
      ),
    );
  }
}
