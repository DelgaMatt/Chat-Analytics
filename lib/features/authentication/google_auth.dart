import 'package:chat_analytics/features/authentication/auth_controller.dart';
import 'package:chat_analytics/pages/ind_record_page.dart';
import 'package:flutter/material.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          )),
      onPressed: () async {
        await FirebaseAuthController().signInWithGoogle();
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IndRecordScreen()),
        );
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
    );
  }
}
