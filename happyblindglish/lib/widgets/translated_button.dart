import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

  Future<void> _speakNormal() async {
    await _stopSpeech();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.7); // Velocidad lenta
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
    return Semantics(
      label:
          "${widget.text}. pulsar una vez para pronunciar lentamente, mantener presionado para seleccionar",
      child: GestureDetector(
        excludeFromSemantics: true,
        onLongPress: () async {
          if (!block) {
            if (anotherEvent) {
              anotherEvent = false;
            }
            _spellOut();
          }
        },
        onTap: () {
          widget.onPressed!();
          _speakNormal();
        },
        child: Container(
          color: Colors.indigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Semantics(
                    excludeSemantics: true,
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: () {
                  _speakSlowly();
                },
                icon: Semantics(
                  label: "Pronunciar lentamente",
                  child: const Icon(Icons.volume_down),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
