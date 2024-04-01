import 'dart:async';
import 'dart:convert';

import 'package:chat_analytics/app/config/env_config.dart';
import 'package:chat_analytics/features/voiceTranscription/ind_waveform.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/io.dart';

final serverUrl = EnvConfig.dgServerUrl;
final apiKey = EnvConfig.dgApiKey;

class IndTranscriberBox extends StatefulWidget {
  const IndTranscriberBox({super.key});

  @override
  State<IndTranscriberBox> createState() => _IndTranscriberBox();
}

class _IndTranscriberBox extends State<IndTranscriberBox> {
  String myText = "To start transcribing your voice, press start.";

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

      updateText(parsedJson['channel']['alternatives'][0]['transcript']);
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

  void startRecord() async {
    try {
      resetText();
      _initStream();

      await _recorder.start();

      setState(() {});
    } on Exception catch (error) {
      print(error);
      rethrow;
    }
  }

  void stopRecord() async {
    await _recorder.stop();

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondary,
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
                  onPressed: () {},
                  child: const Text(
                    "View Text",
                  ),
                ),
                const SizedBox(width: 15),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "View Summary",
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: 150,
                  child: Text(
                    myText,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 50,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
              ),
            ],
          ),
          const IndWaveform(),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    updateText('');
                    startRecord();
                  },
                  child: const Text('Start', style: TextStyle(fontSize: 30)),
                ),
                const SizedBox(width: 5),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
    );
  }
}
