import 'package:audioplayers/audioplayers.dart';
import 'package:dart_levenshtein/dart_levenshtein.dart';
import 'package:flutter/material.dart';
import 'package:happyblindglish/models/palabra.dart';
import 'package:happyblindglish/providers/db_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LeccionButton extends StatefulWidget {
  final void Function()? onPressed;
  final void Function(Palabra learnedWord)? onCorrectPronunciation;
  final Palabra palabra;

  const LeccionButton({
    super.key,
    required this.onCorrectPronunciation,
    required this.onPressed,
    required this.palabra,
  });

  @override
  State<LeccionButton> createState() => _LeccionButtonState();
}

void _playSound(AssetSource sound) async {
  try {
    await _audioPlayer.play(sound);
  } catch (e) {
    print("Error al reproducir sonido: $e");
  }
}

bool listenedOnce = false;
final AudioPlayer _audioPlayer = AudioPlayer();

class _LeccionButtonState extends State<LeccionButton> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final db = DatabaseProvider();
  void _startListening() async {
    final targetWord = widget.palabra.palabraIngles.toLowerCase().trim();
    const double similarityThreshold = 0.3; // Ajusta el umbral según tolerancia

    if (await _speechToText.initialize()) {
      print("SpeechToText inicializado correctamente.");

      _speechToText.listen(
        onResult: (result) async {
          print(result.alternates);
          if (!result.finalResult) return; // Esperar a que termine de hablar

          String recognizedPhrase = result.recognizedWords.toLowerCase().trim();
          print("Frase reconocida: $recognizedPhrase");

          List<String> wordsInPhrase =
              recognizedPhrase.split(" "); // Separar en palabras
          print("Palabras separadas: $wordsInPhrase");

          bool esCorrecto = false;

          for (var word in wordsInPhrase) {
            double similarity = jaccardSimilarity(word, targetWord);
            print(
                "Comparando '$word' con '$targetWord' - Similaridad: $similarity");

            if (similarity >= similarityThreshold) {
              esCorrecto = true;
              break;
            }
          }

          if (esCorrecto) {
            _playSound(AssetSource("sonidos/assert.mp3"));
            print("Palabra reconocida correctamente. Marcando como aprendida.");
            Palabra nuevaPalabra = Palabra(
              palabraEspanol: widget.palabra.palabraEspanol,
              palabraIngles: widget.palabra.palabraIngles,
              tipo: widget.palabra.tipo,
              nivel: widget.palabra.nivel,
              aprendido: true, // ✅ Cambiando el valor correctamente
            );
            await db.updatePalabra(
                nuevaPalabra.palabraEspanol, nuevaPalabra.toMap());
            print(widget.palabra);
            widget.onCorrectPronunciation!(nuevaPalabra);
          } else {
            print("Palabra incorrecta.");
            _playSound(AssetSource("sonidos/wrong.mp3"));
          }
          _speechToText.stop();
        },
        listenFor: const Duration(seconds: 5),
        localeId: "en-US",
      );
    } else {
      print("Error al inicializar SpeechToText.");
    }
  }

  double jaccardSimilarity(String a, String b) {
    Set<String> setA = a.split('').toSet();
    Set<String> setB = b.split('').toSet();

    int intersection = setA.intersection(setB).length;
    int union = setA.union(setB).length;

    return union == 0 ? 0.0 : intersection / union;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "${widget.palabra.palabraEspanol}.Presiona para traducir a inglés",
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          color: Colors.indigo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Semantics(
                  excludeSemantics: true,
                  child: Text(
                    widget.palabra.palabraEspanol,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: _startListening,
                icon: Semantics(
                  label: "Pronunciar con tu voz",
                  child: const Icon(Icons.mic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
