import 'package:chat_analytics/features/voiceTranscription/ind_transcriber_box.dart';
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
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [IndTranscriberBox()],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).colorScheme.tertiary,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Records'),
        BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: 'Insight')
      ]),
    );
  }
}
