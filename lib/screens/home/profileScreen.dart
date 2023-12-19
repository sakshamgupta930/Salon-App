import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          const Center(child: Text("SignOut")),
          IconButton(
            onPressed: () {
              auth.signOut().then((value) => Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const LoginScreen(),
                  )).onError((error, stackTrace) => ScaffoldMessenger.of(
                      context)
                  .showSnackBar(SnackBar(content: Text(error.toString())))));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: const Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
