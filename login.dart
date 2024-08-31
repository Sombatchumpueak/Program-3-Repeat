import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/users.dart';
import '../models/config.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  Users user = Users();
  List<Users> users = [];

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    loadUserData();

    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      users = List<Users>.from(data['users'].map((x) => Users.fromJson(x)));
    });
  }

  Future<void> login(Users user) async {
    Users? matchedUser = users.firstWhere(
      (u) => u.email == user.email && u.password == user.password,
      orElse: () => Users(),
    );

    if (matchedUser.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username or password invalid")),
      );
    } else {
      Configure.login = matchedUser;
      Navigator.pushNamed(context, "/"); 
    }
  }

  Widget emailInputField() {
    return TextFormField(
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: _emailFocusNode.hasFocus ? const Color.fromARGB(255, 243, 33, 33) : Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: _emailFocusNode.hasFocus ? const Color.fromARGB(255, 243, 33, 33) : Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 243, 33, 33)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) {
        user.email = newValue;
      },
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      focusNode: _passwordFocusNode,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: _passwordFocusNode.hasFocus ? const Color.fromARGB(255, 243, 33, 33) : Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: _passwordFocusNode.hasFocus ? const Color.fromARGB(255, 243, 33, 33) : Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 243, 33, 33)),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) {
        user.password = newValue;
      },
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          login(user);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 33, 33), // เปลี่ยนสีปุ่มเป็นสีฟ้า
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white), // ตัวอักษรสีขาว
      ),
    );
  }

  Widget backButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 243, 33, 33), // เปลี่ยนสีปุ่มเป็นสีฟ้า
      ),
      child: const Text(
        'Back',
        style: TextStyle(color: Colors.white), // ตัวอักษรสีขาว
      ),
    );
  }

  Widget signUpButton() {
    return TextButton(
      onPressed: () {
        // Implement sign up action
      },
      child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ลบ AppBar ออก
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  emailInputField(),
                  const SizedBox(height: 20),
                  passwordInputField(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loginButton(),
                      const SizedBox(width: 10),
                      backButton(),
                      const SizedBox(width: 10),
                      signUpButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
