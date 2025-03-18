import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:happyblindglish/utils/app_utils.dart';

class TranslatedButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;

  const TranslatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<TranslatedButton> createState() => _TranslatedButtonState();
}

class _TranslatedButtonState extends State<TranslatedButton> {
  bool block = false;
  bool anotherEvent = false;
  final FlutterTts _flutterTts = FlutterTts();

  /// Cancela cualquier reproducción de voz antes de iniciar una nueva
  Future<void> _stopSpeech() async {
    await _flutterTts.stop();
  }

  Future<void> _speakSlowly() async {
    await _stopSpeech();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.2); // Velocidad lenta
    await _flutterTts.speak(
      widget.text,
    );
  }

  Future<void> _spellOut() async {
    await _stopSpeech();
    block = true;
    await _flutterTts.setLanguage("es-MX");
    await _flutterTts.setSpeechRate(0.5); // Velocidad moderada
    bool firstTime = true;
    List<String> letters = widget.text.toUpperCase().split('');
    await Future.forEach(letters, (letter) async {
      if (anotherEvent) {
        return;
      } else {
        if (firstTime) {
          await Future.delayed(
              const Duration(milliseconds: 1000)); // Pausa entre letras
          firstTime = false;
        }
        await _flutterTts.speak(letter); // Pronuncia la letra
        await Future.delayed(
            const Duration(milliseconds: 500)); // Pausa entre letras
      }
    });
    block = false;
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppUtils.textButtonPadding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Semantics(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (block) {
                anotherEvent = true;
              }
              _speakSlowly();
            },
            icon: Semantics(
              label: "Pronunciar lentamente",
              child: const Icon(Icons.volume_down),
            ),
          ),
          IconButton(
            onPressed: () {
              if (!block) {
                if (anotherEvent) {
                  anotherEvent = false;
                }
                _spellOut();
              }
            },
            icon: Semantics(
              label: "Deletrear",
              child: const Icon(Icons.spellcheck),
            ),
          ),
        ],
      ),
    );
  }
}
