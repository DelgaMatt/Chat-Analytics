import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

class IndWaveform extends StatefulWidget {
  const IndWaveform({super.key});

  @override
  State<IndWaveform> createState() => _IndWaveform();
}

class _IndWaveform extends State<IndWaveform> {
  late final RecorderController controller = RecorderController();
  
  bool isRecording = false;

  void _initialiseController() {
    controller
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;
  }

  @override
  void initState() {
    super.initState();
    _initialiseController();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15)
            ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          tooltip: 'Start recording',
          onPressed: () {
            setState(() {
              isRecording = !isRecording;
            });
          },
          icon: isRecording ? const Icon(Icons.play_circle) : const Icon(Icons.pause_circle),
        ),
        AudioWaveforms(
          size: Size(MediaQuery.of(context).size.width / 2, 50),
          recorderController: controller,
          enableGesture: true,
          waveStyle: const WaveStyle(
            waveColor: Colors.white,
            showDurationLabel: true,
            spacing: 8.0,
            showBottom: false,
            extendWaveform: true,
            showMiddleLine: false,
          ),
        ),
      ]),
    );
  }
}
