import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/util/utils.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 50,
          child: const Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "User",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        Text(
          _auth.currentUser?.email ?? "",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        Text(
          "Login terakhir: ${simpleDate(_auth.currentUser?.metadata.lastSignInTime?.toIso8601String())}",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Text("Logout"),
          onPressed: () {
            _auth.signOut();
            GoRouter.of(context).go('/login');
          },
        )
      ],
    )));
  }
}
