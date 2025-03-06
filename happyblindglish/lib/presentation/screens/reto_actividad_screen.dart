import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/models/pregunta_respuestas.dart';
import 'package:happyblindglish/models/reto.dart';
import 'package:happyblindglish/presentation/blocs/reto_cubit.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';
import 'package:happyblindglish/widgets/custom_button_1.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';

class RetoActividadScreen extends StatefulWidget {
  const RetoActividadScreen({super.key});

  @override
  State<RetoActividadScreen> createState() => _RetoActividadScreenState();
}

class _RetoActividadScreenState extends State<RetoActividadScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  late List<PreguntaRespuestas> preguntas;
  int _indicePregunta = 0; // Índice de la pregunta actual
  static const int _maxPreguntas = 5; // Número de iteraciones

  @override
  void initState() {
    super.initState();
    preguntas = generarPreguntas(bancoDePalabras, _maxPreguntas);
    _flutterTts.setLanguage("en-US");
    _flutterTts.setPitch(1.0);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> bancoDePalabras = [
    {"espanol": "perro", "ingles": "dog", "tipo": "animal"},
    {"espanol": "gato", "ingles": "cat", "tipo": "animal"},
    {"espanol": "mesa", "ingles": "table", "tipo": "objeto"},
    {"espanol": "correr", "ingles": "run", "tipo": "acción"},
    {"espanol": "manzana", "ingles": "apple", "tipo": "comida"},
    {"espanol": "silla", "ingles": "chair", "tipo": "objeto"},
    {"espanol": "comer", "ingles": "eat", "tipo": "acción"},
    {"espanol": "león", "ingles": "lion", "tipo": "animal"},
    {"espanol": "rojo", "ingles": "red", "tipo": "color"},
    {"espanol": "azul", "ingles": "blue", "tipo": "color"},
  ];

  List<PreguntaRespuestas> generarPreguntas(
      List<Map<String, dynamic>> banco, int cantidad) {
    List<PreguntaRespuestas> preguntas = [];
    Random random = Random();

    for (int i = 0; i < cantidad; i++) {
      var palabra = banco[random.nextInt(banco.length)];
      String preguntaTexto = "¿Cómo se dice ${palabra['espanol']} en inglés?";
      String respuestaCorrecta = palabra['ingles'];
      String tipoPalabra = palabra['tipo'];

      List<String> opcionesIncorrectas = banco
          .where((p) =>
              p['tipo'] == tipoPalabra && p['ingles'] != respuestaCorrecta)
          .map((p) => p['ingles'] as String)
          .toList();

      while (opcionesIncorrectas.length < 3) {
        var palabraExtra = banco[random.nextInt(banco.length)];
        if (!opcionesIncorrectas.contains(palabraExtra['ingles']) &&
            palabraExtra['ingles'] != respuestaCorrecta) {
          opcionesIncorrectas.add(palabraExtra['ingles'] as String);
        }
      }

      opcionesIncorrectas.shuffle();
      List<String> respuestasIncorrectas = opcionesIncorrectas.take(3).toList();

      List<Respuesta> respuestas = [
        Respuesta(respuesta: respuestaCorrecta, correcta: true),
        ...respuestasIncorrectas
            .map((r) => Respuesta(respuesta: r, correcta: false)),
      ];

      respuestas.shuffle();

      preguntas.add(PreguntaRespuestas(
        pregunta: preguntaTexto,
        respuestas: respuestas,
        tipoPalabra: tipoPalabra,
      ));
    }

    return preguntas;
  }

  void _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('sonidos/assert.mp3'));
    } catch (e) {
      print("Error al reproducir sonido: $e");
    }
  }

  void _siguientePregunta() {
    if (_indicePregunta < _maxPreguntas - 1) {
      SemanticsService.announce(
          "Pregunta ${_indicePregunta + 2} de $_maxPreguntas${preguntas[0].pregunta}",
          TextDirection.ltr);
      setState(() {
        _indicePregunta++;
      });
    } else {
      SemanticsService.announce(
          "40 puntos ganados, actividad finalizada, Te encuentras en: Retos del día",
          TextDirection.ltr);
      Navigator.pop(context);
    }
  }

  void _mostrarMensajeFinal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¡Actividad finalizada!"),
        content: const Text("Has completado las 5 preguntas."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Aceptar"),
          )
        ],
      ),
    );
  }

  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<RetoCubit, Reto?>(
        builder: (context, state) {
          if (firstTime) {
            firstTime = false;
            SemanticsService.announce(state!.nombre, TextDirection.ltr);
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    child: Text(
                      "Pregunta ${_indicePregunta + 1} de $_maxPreguntas",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Semantics(
                    child: Text(
                      preguntas[_indicePregunta].pregunta,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: preguntas[_indicePregunta].respuestas.length,
                    semanticChildCount: preguntas[_indicePregunta]
                        .respuestas
                        .length, // Importante
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Semantics(
                          label: preguntas[_indicePregunta]
                              .respuestas[index]
                              .respuesta
                              .toUpperCase(),
                          child: Semantics(
                            excludeSemantics: true,
                            child: CustomButton1(
                              onPressed: () async {
                                if (preguntas[_indicePregunta]
                                    .respuestas[index]
                                    .correcta) {
                                  _playSound();
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  _siguientePregunta();
                                }
                              },
                              text: preguntas[_indicePregunta]
                                  .respuestas[index]
                                  .respuesta
                                  .toUpperCase(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Semantics(
                    container: false,
                    label: "Leer instrucciones otra vez",
                    excludeSemantics: true,
                    child: IconButton(
                      icon: const Icon(Icons.replay_outlined),
                      onPressed: () {
                        SemanticsService.announce(
                            preguntas[0].pregunta, TextDirection.ltr);
                      },
                    ),
                  ),
                  CustomButton2(
                    onPressed: () => Navigator.pop(context),
                    text: Strings.terminarActividad,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
