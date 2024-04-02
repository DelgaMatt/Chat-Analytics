import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chat_analytics/app/config/env_config.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/io.dart';

final serverUrl = EnvConfig.dgServerUrl;
final apiKey = EnvConfig.dgApiKey;
final openApiKey = EnvConfig.openAiApiKey;

class IndTranscriberBox extends StatefulWidget {
  const IndTranscriberBox({super.key});

  @override
  State<IndTranscriberBox> createState() => _IndTranscriberBox();
}

class _IndTranscriberBox extends State<IndTranscriberBox> {
  String myText = "To start transcribing your voice, press start.";
  bool transcriptionView = true;
  String mySummary = 'Summarizing your transcription';
  bool expanded = false;


  final RecorderStream _recorder = RecorderStream();

  late StreamSubscription _recorderStatus;
  late StreamSubscription _audioStream;

  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(onLayoutDone);
  }

  @override
  void dispose() {
    _recorderStatus.cancel();
    _audioStream.cancel();
    channel.sink.close();

    super.dispose();
  }

  Future<void> _initStream() async {
    channel = IOWebSocketChannel.connect(Uri.parse(serverUrl),
        headers: {'Authorization': 'Token $apiKey'});

    channel.stream.listen((event) async {
      final parsedJson = jsonDecode(event);

      print(parsedJson);

      final textFeedback =
          parsedJson['channel']?['alternatives'][0]['transcript'];

      generateText(textFeedback);
      updateText(textFeedback);
    });

    _audioStream = _recorder.audioStream.listen((data) {
      channel.sink.add(data);
    });

    _recorderStatus = _recorder.status.listen((status) {
      if (mounted) {
        setState(() {});
      }
    });

    await Future.wait([
      _recorder.initialize(),
    ]);
  }

  Future<void> startRecord() async {
    try {
      resetText();
      await _initStream();
      await _recorder.start();
    } on Exception catch (error) {
      print('catch $error');
    }
  }

  void stopRecord() async {
    await _recorder.stop();
  }

  void onLayoutDone(Duration timeStamp) async {
    await Permission.microphone.request();
    setState(() {});
  }

  void updateText(newText) {
    setState(() {
      myText = newText;
    });
  }

  void resetText() {
    setState(() {
      myText = '';
    });
  }

// ------------------------------------------------------------ Sentimental Analysis ---->
  Future<String?> generateText(String parsedJSON) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openApiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-instruct',
        'prompt':
            "Write a short summary as a sentimental analysis on the transcription.\n\nTranscription$parsedJSON\"\nSentiment:",
        'temperature': 0.7,
        'max_tokens': 100,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        mySummary = data['choices'][0]['text'].toString();
      });

      return data['choices'][0]['text'].toString();
    } else {
      throw Exception('Failed to generate text: ${response.statusCode}');
    }
  }
  // ----------------------------------------------------------------------------------->

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondaryContainer),
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).colorScheme.secondary, Colors.black]),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        transcriptionView = true;
                      });
                    },
                    child: const Text(
                      "View Text",
                    ),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        transcriptionView = false;
                      });
                    },
                    child: const Text(
                      "View Summary",
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // height: 125,
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  if (transcriptionView)
                    Text(
                      myText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  if (!transcriptionView)
                    Text(
                      mySummary,
                      textAlign: TextAlign.center,
                      overflow: expanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      maxLines: expanded ? null : 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                ]),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      // updateText('');
                      await startRecord();
                    },
                    child: const Text('Start', style: TextStyle(fontSize: 30)),
                  ),
                  const SizedBox(width: 5),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      stopRecord();
                    },
                    child: const Text('Stop', style: TextStyle(fontSize: 30)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
