import 'package:flutter/material.dart';

class AnalysisSliders extends StatelessWidget {
  const AnalysisSliders({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Theme.of(context).colorScheme.secondary, Colors.black]),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 170,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: const Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Trust',
                      textAlign: TextAlign.start,
                    ),
                    Slider(
                      value: 0.3,
                      // secondaryTrackValue: 0.5,
                      onChanged: null,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Sentiment',
                      textAlign: TextAlign.start,
                    ),
                    Slider(
                      value: 0.6,
                      onChanged: null,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 170,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Empathy',
                      textAlign: TextAlign.start,
                    ),
                    Slider(
                      value: 0.5,
                      onChanged: null,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Charisma',
                      textAlign: TextAlign.start,
                    ),
                    Slider(
                      value: 0.4,
                      onChanged: null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
