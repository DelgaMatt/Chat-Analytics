import 'package:chat_analytics/firebase_options.dart';
import 'package:chat_analytics/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData().copyWith(
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(199, 0, 89, 140)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(200, 0, 102, 140),
  ),
  brightness: Brightness.light,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Satellite',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const AuthPage()
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (ctx, snapshot) {
      //     // if firebase is still waiting or loading the token..
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const SplashScreen();
      //     }

      //     if (snapshot.hasData) {
      //       return const ChatScreen();
      //     }
      //     return const AuthScreen();
      //   },
      // ),
    );
  }
}
