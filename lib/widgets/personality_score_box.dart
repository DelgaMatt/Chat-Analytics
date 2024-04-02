import 'package:flutter/material.dart';

class PersonalityBox extends StatelessWidget {
  const PersonalityBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Theme.of(context).colorScheme.secondary, Colors.black]),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
        Icon(
          Icons.bar_chart,
          size: 50,
        ),
        Column(
          children: [
            Text(
              'Personality Score',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              '8/10',
              style: TextStyle(fontSize: 25),
            ),
          ],
        )
      ]),
    );
  }
}
