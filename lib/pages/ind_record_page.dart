import 'package:chat_analytics/features/analysis/pseudo_analysis_data.dart';
import 'package:chat_analytics/features/analysis/text_analysis.dart';
import 'package:chat_analytics/features/voiceTranscription/ind_transcriber_box.dart';
import 'package:chat_analytics/widgets/analysis_sliders.dart';
import 'package:chat_analytics/widgets/personality_score_box.dart';
import 'package:flutter/material.dart';

class IndRecordScreen extends StatefulWidget {
  const IndRecordScreen({super.key});

  @override
  State<IndRecordScreen> createState() => _IndRecordScreenState();
}

class _IndRecordScreenState extends State<IndRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, //
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Records'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
      ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IndTranscriberBox(),
              AnalysisSliders(),
              PersonalityBox(),
              TextAnalysis(
                availableAnalysis: pseudoData,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 4,
          backgroundColor: const Color.fromARGB(255, 52, 52, 52),
          fixedColor: Theme.of(context).colorScheme.tertiary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Records'),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph), label: 'Insight')
          ]),
    );
  }
}
