import 'package:flutter/material.dart';
import 'package:flutter_application_8/models/users.dart';
import '../models/user_info.dart';
import 'side_menu.dart';
import 'add_edit_user.dart';

class Home extends StatefulWidget {
  static const routeName = "/";

  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Users> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 243, 33, 33),
      ),
      drawer: const SideMenu(),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(users[index].fullname!),
              subtitle: Text(users[index].email!),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  // Navigate to the edit screen with the current user data
                  final updatedUser = await Navigator.push<Users>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditUser(user: users[index]),
                    ),
                  );

                  if (updatedUser != null) {
                    setState(() {
                      users[index] = updatedUser;
                    });
                  }
                },
              ),
              onTap: () {
                // Navigate to UserInfo screen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfo(user: users[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.push<Users>(
            context,
            MaterialPageRoute(builder: (context) => const AddEditUser()),
          );

          if (newUser != null) {
            setState(() {
              users.add(newUser);
            });
          }
        },
        child: const Icon(Icons.person_add, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 243, 33, 33),
      ),
    );
  }
}
