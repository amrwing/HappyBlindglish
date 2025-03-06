import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/presentation/blocs/reto_cubit.dart';
import 'package:happyblindglish/presentation/blocs/tutorial_preference.dart';
import 'package:happyblindglish/presentation/screens/challenges_main_screen.dart';
import 'package:happyblindglish/presentation/screens/onboarding_screen.dart';
import 'package:happyblindglish/presentation/screens/main_screen.dart';
import 'package:happyblindglish/presentation/screens/progress_screen.dart';
import 'package:happyblindglish/presentation/screens/reto_actividad_screen.dart';
import 'package:happyblindglish/presentation/screens/retos_del_dia_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:round_spot/round_spot.dart' as rs;

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TutorialPreferenceCubit(),
        ),
        BlocProvider(
          create: (context) => RetoCubit(),
          lazy: true,
        ),
      ],
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
        "reto_actividad_screen": (context) => const RetoActividadScreen(),
        "pantalla_inicial_tutorial": (context) => const OnboardingScreen(
        
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
        "retos_del_dia": (context) => const RetosDelDiaScreen()
      },
    );
  }
}
