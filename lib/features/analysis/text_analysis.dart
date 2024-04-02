import 'package:chat_analytics/features/analysis/pseudo_analysis_data.dart';
import 'package:flutter/material.dart';

class TextAnalysis extends StatefulWidget {
  const TextAnalysis({required this.availableAnalysis, super.key});

  final List<Analysis> availableAnalysis;

  @override
  State<TextAnalysis> createState() => _TextAnalysisState();
}

class _TextAnalysisState extends State<TextAnalysis> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Theme.of(context).colorScheme.secondary, Colors.black]),
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          for (final analysis in pseudoData)
            Column(
              children: [
                const SizedBox(height: 25),
                Text(
                  analysis.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      analysis.response,
                      overflow: _expanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      maxLines: _expanded ? null : 2,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
