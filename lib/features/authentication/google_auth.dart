import 'package:chat_analytics/features/authentication/auth_controller.dart';
import 'package:chat_analytics/pages/ind_record_page.dart';
import 'package:flutter/material.dart';

class GoogleAuth extends StatefulWidget {
  const GoogleAuth({super.key});

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  bool isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hello, Human', style: TextStyle(fontSize: 67)),
        const SizedBox(
          height: 25,
        ),
        if(!isAuthenticating)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(
                color: Theme.of(context).colorScheme.secondaryContainer,
              )),
          onPressed: () async {
            setState(() {
              isAuthenticating = true;
            });
            await FirebaseAuthController().signInWithGoogle();
            if (context.mounted) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const IndRecordScreen()),
              );
            }
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
                Text(
                  "Login with Gmail",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ],
            ),
          ),
        ),
        if (isAuthenticating)
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondaryContainer,
          )
      ],
    );
  }
}
