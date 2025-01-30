import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:happyblindglish/screens/challenges/challenges_main_screen.dart';
import 'package:happyblindglish/screens/challenges/letter_challenges/challenges_with_letters.dart';
import 'package:happyblindglish/screens/challenges/letter_challenges/letter_challenge_1.dart';
import 'package:happyblindglish/screens/challenges/letter_challenges/letter_challenge_2.dart';
import 'package:happyblindglish/screens/challenges/word_challenges/challenge_words_basic.dart';
import 'package:happyblindglish/screens/challenges/word_challenges/challenges_with_words.dart';
import 'package:happyblindglish/screens/main_screen.dart';
import 'package:happyblindglish/screens/my_progress/progress_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:round_spot/round_spot.dart' as rs;

String? sessionFolderPath;
void main() {
  runApp(rs.initialize(
    child: const MyApp(),
    localRenderCallback: (data, info) async {
      // Asegura que todas las imágenes de la sesión se guarden en la misma carpeta
      await saveImageInSingleSession(data, info);
    },
  ));
}

/// Crea un único directorio para la sesión si aún no existe y guarda las imágenes dentro
Future<void> saveImageInSingleSession(
    Uint8List data, rs.OutputInfo info) async {
  // Verifica si ya existe un directorio de sesión
  if (sessionFolderPath == null) {
    // Obtén el directorio de descargas
    var downloadsDir = await getDownloadsDirectory();
    if (downloadsDir == null) {
      throw Exception("No se pudo obtener el directorio de descargas.");
    }

    // Genera un nombre único para la sesión
    String sessionFolderName =
        "Session_${DateTime.now().millisecondsSinceEpoch}";
    sessionFolderPath = '${downloadsDir.path}/$sessionFolderName';

    // Crea el directorio de la sesión
    Directory(sessionFolderPath!).createSync();
  }

  // Guarda las imágenes en el directorio de la sesión
  String fileName = "${info.page}_${info.area}.png";
  File('${sessionFolderPath!}/$fileName').writeAsBytesSync(data);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [rs.Observer()],
      initialRoute: "pantalla_principal",
      routes: {
        "pantalla_principal": (context) => const MainScreen(),
        "pantalla_mi_progreso": (context) => const ProgressScreen(),
        "pantalla_retos": (context) => const ChallengesMainScreen(),
        "pantalla_retos_con_letras": (context) => const ChallengesWithLetters(),
        "pantalla_retos_con_palabras": (context) => const ChallengesWithWords(),
        "pantalla_reto_con_letras_1": (context) => const LetterChallenge1(),
        "pantalla_reto_con_letras_2": (context) => const LetterChallenge2(),
        "reto_palabras_basico": (context) => const PronunciationScreen()
      },
    );
  }
}
