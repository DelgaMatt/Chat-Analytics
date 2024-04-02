// import 'dart:convert';

// import 'package:chat_analytics/app/config/env_config.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AiSummaryContainer extends StatefulWidget {
//   const AiSummaryContainer({required this.parsedJSON, super.key});

//   final String parsedJSON;

//   @override
//   State<AiSummaryContainer> createState() => _AiSummaryContainerState();
// }

// class _AiSummaryContainerState extends State<AiSummaryContainer> {
//   String mySummary = 'Summarizing your transcription';
//   final apiKey = EnvConfig.openAiApiKey;

//   Future<String> generateText(String parsedJSON) async {
//     final response = await http.post(
//       Uri.parse('https://api.openai.com/v1/completions'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey',
//       },
//       body: jsonEncode({
//         'model': 'gpt-3.5-turbo-instruct',
//         'prompt':
//             "Write a short summary as a sentimental analysis on the transcription.\n\nTranscription$parsedJSON\"\nSentiment:",
//         'temperature': 0.7,
//         'max_tokens': 100,
//       }),
//     );
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       setState(() {
//         mySummary = data;
//       });

//       return data['choices'][0]['text'];
//     } else {
//       throw Exception('Failed to generate text: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 125,
//       margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
//       padding: const EdgeInsets.all(10),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.black, borderRadius: BorderRadius.circular(20)),
//       child: Column(children: [
//         Text(
//           mySummary,
//           textAlign: TextAlign.center,
//           overflow: TextOverflow.ellipsis,
//           maxLines: 50,
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//               color: Theme.of(context).colorScheme.tertiary),
//         ),
//       ]),
//     );
//   }
// }
