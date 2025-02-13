import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/presentation/blocs/tutorial_preference.dart';
import 'package:happyblindglish/presentation/screens/challenges/challenges_main_screen.dart';
import 'package:happyblindglish/presentation/screens/challenges/letter_challenges/challenges_with_letters.dart';
import 'package:happyblindglish/presentation/screens/challenges/letter_challenges/letter_challenge_1.dart';
import 'package:happyblindglish/presentation/screens/challenges/letter_challenges/letter_challenge_2.dart';
import 'package:happyblindglish/presentation/screens/challenges/word_challenges/challenges_with_words.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_tutorial_scaffold.dart';
import 'package:happyblindglish/presentation/screens/main_screen.dart';
import 'package:happyblindglish/presentation/screens/my_progress/progress_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:round_spot/round_spot.dart' as rs;

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TutorialPreferenceCubit())],
      child: const MyApp(),
    );
  }
}

String? sessionFolderPath;
void main() {
  runApp(rs.initialize(
    config: rs.Config(heatMapStyle: rs.HeatMapStyle.smooth),
    loggingLevel: rs.LogLevel.warning,
    child: const BlocsProviders(),
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
      initialRoute: "pantalla_inicial_tutorial",
      routes: {
        "pantalla_inicial_tutorial": (context) => const MainTutorialScreen(
              text:
                  "Bienvenido a HappyBlindglish, puedes empezar seleccionando el modo de la aplicación que prefieras",
            ),
        "pantalla_principal": (context) => const MainScreen(
              text:
                  "Bienvenido a HappyBlindglish, ahora mismo te encuentras en la pantalla principal. Aquí encontrarás 3 opciones: un botón para ir a las actividades y retos, otro botón para ver tu progreso y puntuación y un botón para regresar al menú de preferencias.",
            ),
        "pantalla_mi_progreso": (context) => const ProgressScreen(
            text:
                "En esta pantalla encontrarás 4 opciones: Un botón para escuchar cuantas palabras has aprendido, un botón para conocer tu puntaje, un botón para saber tu racha o cuantos días has jugado sin parar y finalmente el botón de regresar al menú"),
        "pantalla_retos": (context) => const ChallengesMainScreen(
              text:
                  "En esta pantalla encontrarás 4 opciones: Un botón que te lleva a los retos para aprender las letras en ingles, un botón para hacerlo con palabras, un botón para hacerlo con frases y finalmente un botón de regreso",
            ),
        "pantalla_retos_con_letras": (context) => const ChallengesWithLetters(
              text:
                  "En esta pantalla encontrarás varios botones con distintos retos para aprender las letras en inglés y hasta abajo el botón de regresar",
            ),
        "pantalla_retos_con_palabras": (context) => const ChallengesWithWords(
              text:
                  "En esta pantalla encontrarás varios botones con distintos retos para aprender palabras en inglés y hasta abajo el botón de regresar",
            ),
        "pantalla_reto_con_letras_1": (context) => const LetterChallenge1(
              text:
                  "En esta pantalla encontrarás 3 botones: uno que te dice como se realizará la actividad, uno para comenzar a realizar la actividad y finalmente el botón de regresar",
            ),
        "pantalla_reto_con_letras_2": (context) => const LetterChallenge2(
              text:
                  "En esta pantalla encontrarás 3 botones: uno que te dice como se realizará la actividad, uno para comenzar a realizar la actividad y finalmente el botón de regresar",
            ),
      },
    );
  }
}
