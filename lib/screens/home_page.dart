import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();
  var _speechEnabled = false;
  String _wordsSpoken = '';
  double _confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _confidenceLevel = 0;
    });
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech to text'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Text(
                  _speechToText.isListening
                      ? "Listening....."
                      : _speechEnabled
                          ? "Press the button to start speaking"
                          : "Speech not available",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _wordsSpoken,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              Text(
                'Confidence Level: ${(_confidenceLevel * 100).toStringAsFixed(1)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
            const SizedBox(height: 80,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        child: _speechEnabled && _speechToText.isListening
            ? const Icon(Icons.mic)
            : const Icon(Icons.mic_none),
      ),
    );
  }
}
