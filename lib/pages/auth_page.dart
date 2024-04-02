import 'package:chat_analytics/features/authentication/google_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(

            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: const GoogleAuth(),
          ),
        ),
    );
  }
}
