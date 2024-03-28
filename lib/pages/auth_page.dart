import 'package:chat_analytics/pages/home_page.dart';
import 'package:chat_analytics/shared/firebase/firebase.dart';
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
      // appBar: ,
      body: Container(
        // styling
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuthentication().signInWithGoogle();
              //   await Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => HomeScreen()),
              //   );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/images/google_logo.jpg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Login with Gmail",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
