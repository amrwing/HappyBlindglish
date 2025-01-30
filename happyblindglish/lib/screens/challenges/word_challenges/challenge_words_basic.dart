import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PronunciationScreen extends StatefulWidget {
  const PronunciationScreen({super.key});

  @override
  State<PronunciationScreen> createState() => _PronunciationScreenState();
}

class _PronunciationScreenState extends State<PronunciationScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedWord = '';

  final List<Map<String, String>> _words = [
    {"english": "Hello", "spanish": "Hola"},
    {"english": "Bye", "spanish": "Adiós"},
    {"english": "Please", "spanish": "Por favor"},
    {"english": "Thanks", "spanish": "Gracias"},
    {"english": "Good", "spanish": "Bueno"},
    {"english": "Bad", "spanish": "Malo"}
  ];

  final Map<String, bool> _status = {};

  @override
  void initState() {
    super.initState();
    for (var word in _words) {
      _status[word['english']!] = false;
    }
  }

  void _listen(String targetWord) async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(onResult: (result) {
          setState(() {
            _recognizedWord = result.recognizedWords;
          });

          if (_recognizedWord.toLowerCase() == targetWord.toLowerCase()) {
            setState(() {
              _status[targetWord] = true;
            });
            _speech.stop();
            setState(() {
              _isListening = false;
            });
          } else {
            _playErrorSound();
          }
        });
      }
    } else {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  void _playErrorSound() {
    // Placeholder for an incorrect sound effect.
    print('Incorrect pronunciation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BASICO'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'PALABRAS COMPLETADAS: ${_status.values.where((s) => s).length}',
                style: const TextStyle(fontSize: 18)),
            Text(
                'PALABRAS RESTANTES: ${_status.values.where((s) => !s).length}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  final word = _words[index];
                  final isCorrect = _status[word['english']!] ?? false;
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      title: Text(word['english']!),
                      subtitle: Text('Traducir: ${word['spanish']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () => _listen(word['english']!),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}
