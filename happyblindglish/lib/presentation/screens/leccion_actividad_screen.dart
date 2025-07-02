import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:happyblindglish/models/leccion.dart';
import 'package:happyblindglish/models/palabra.dart';
import 'package:happyblindglish/presentation/blocs/leccion_cubit.dart';
import 'package:happyblindglish/providers/db_provider.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';
import 'package:happyblindglish/widgets/leccion_button.dart';

class LeccionActividadScreen extends StatefulWidget {
  const LeccionActividadScreen({super.key});

  @override
  State<LeccionActividadScreen> createState() => _LeccionActividadScreenState();
}

class _LeccionActividadScreenState extends State<LeccionActividadScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late Leccion selectedLeccion;
  bool blockUI = false;
  final FlutterTts _flutterTts = FlutterTts();

  List<Palabra> palabrasLeccion = [];
  List<Palabra> currentWords = [];
  int maxPage = 0;
  bool firstTime = true;
  int _currentPage = 0;
  static const int _wordsPerPage = 4; // Cambio aquí, de 5 a 4
  bool showLearnedWords = false;

  @override
  void initState() {
    super.initState();
    _loadLeccionData();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  Future<void> _stopSpeech() async {
    await _flutterTts.stop();
  }

  Future<void> _speakSlowly(String palabraIngles) async {
    _stopSpeech();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.2);
    await _flutterTts.speak(palabraIngles);
  }

  bool anotherEvent = false;
  bool block = false;
  // Future<void> _spellOut(String palabraIngles) async {
  //   _stopSpeech();
  //   block = true;
  //   await _flutterTts.setLanguage("es-MX");
  //   await _flutterTts.setSpeechRate(0.5);
  //   List<String> letters = palabraIngles.toUpperCase().split('');
  //   for (String letter in letters) {
  //     if (anotherEvent) return;
  //     await _flutterTts.speak(letter);
  //     await Future.delayed(const Duration(milliseconds: 500));
  //   }
  //   block = false;
  // }

  void _loadLeccionData() {
    final db = DatabaseProvider();
    selectedLeccion = context.read<LeccionCubit>().state!;
    db
        .getAllPalabrasByTheme(
            selectedLeccion.tema, selectedLeccion.dificultad!)
        .then((value) {
      setState(() {
        palabrasLeccion = value.map((map) => Palabra.fromMap(map)).toList();
        _updateFilteredWords();
      });
    });
  }

  void _announceLeccion(String? nombre) {
    if (firstTime && nombre != null) {
      firstTime = false;
      SemanticsService.announce("Entraste a, $nombre", TextDirection.ltr);
    }
  }

  void _showExitConfirmationDialog() {
    SemanticsService.announce(
        '¿Seguro de que deseas terminar la actividad?', TextDirection.ltr);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Tu progreso se guardará'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                SemanticsService.announce(
                    'Regresaste a lecciones y vocabulario', TextDirection.ltr);
              },
              child: const Text('Sí, terminar'),
            ),
          ],
        );
      },
    );
  }

  bool isLastPage = false;
  bool isFirstPage = false;

  void _updateFilteredWords() {
    // Filtrar las palabras según si son aprendidas o no
    currentWords = palabrasLeccion
        .where((palabra) =>
            showLearnedWords ? palabra.aprendido : !palabra.aprendido)
        .toList();

    // Calcular el valor máximo de la página según el filtro
    setState(() {
      maxPage = (currentWords.length / _wordsPerPage).ceil() - 1;
    });

    // Reiniciar la página actual si es necesario
    if (_currentPage > maxPage) {
      _currentPage = maxPage;
    }
  }

  void _nextPage() async {
    if ((_currentPage + 1) * _wordsPerPage < currentWords.length) {
      setState(() {
        _currentPage++;
        isLastPage = _currentPage ==
            maxPage; // Establecer si estamos en la última página
        isFirstPage = false; // No estamos en la primera página
      });
    } else {
      setState(() {
        isLastPage = true;
      });
    }
    SemanticsService.announce("Pagina ${_currentPage + 1}", TextDirection.ltr);
  }

  void _previousPage() async {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        isFirstPage =
            _currentPage == 0; // Establecer si estamos en la primera página
        isLastPage = false; // No estamos en la última página
      });
    } else {
      setState(() {
        isFirstPage = true;
      });
    }
    SemanticsService.announce("Pagina ${_currentPage + 1}", TextDirection.ltr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Semantics(
            excludeSemantics: true,
            label: "Boton de ayuda",
            button: false,
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Dialogo de instrucciones"),
                        content: const Column(
                          children: [
                            Text(
                                "En esta lección, aprenderás palabras basicas. Para salir podrás usar el botón de 'Terminar actividad' ubicado en la zona baja de la pantalla."),
                            Text("Navega por cada palabra de la lista."),
                            Text(
                                "Cada palabra está contenida en un cuadro con 2 acciones"),
                            Text(
                                "Traducir palabra: esta se activa presionando la opción una vez"),
                            Text(
                                "Pronunciar con tu voz: esta se activa presionando la opción dentro de cada palabra"),
                            Text(
                                "Si pronuncias la palabra correctamente, la palabra se completará como aprendida y desaparecerá de la lista"),
                            Text(
                                "Continúa aprendiendo para ir subiendo de nivel y enfrentar desafíos más grandes")
                          ],
                        ),
                        actions: [
                          GestureDetector(
                            child: const Text("Cerrar cuadro de ayuda"),
                            onTap: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.help),
            ),
          ),
        ],
        centerTitle: true,
        title: Text("Palabras Nivel: ${selectedLeccion.dificultad!}"),
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<LeccionCubit, Leccion?>(
        builder: (context, state) {
          _announceLeccion(state?.nombre);
          return Semantics(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton(), // Usando el botón único
                  _buildWordList(),
                  _buildNavigationRow(),
                  _buildExitButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              showLearnedWords = false;
            });
          },
          child: const Text("Palabras no aprendidas"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showLearnedWords = true;
            });
          },
          child: const Text("Palabras aprendidas"),
        ),
      ],
    );
  }

  Widget _buildWordList() {
    // Verificar si hay palabras disponibles antes de continuar con la paginación
    if (currentWords.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 150, bottom: 150),
        child: Center(
          child: Text(showLearnedWords
              ? "No hay palabras aprendidas"
              : "Ya no hay palabras por aprender"),
        ),
      );
    }

    // Asegurarse de que _currentPage no sea mayor que maxPage
    if (_currentPage > maxPage) {
      _currentPage = maxPage; // Ajustar _currentPage a maxPage si es necesario
    }

    // Limitar las palabras a las 4 de la página actual
    List<Palabra> wordsToDisplay = currentWords
        .skip(_currentPage * _wordsPerPage)
        .take(_wordsPerPage)
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: wordsToDisplay.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LeccionButton(
              onPressed: () =>
                  _speakSlowly(wordsToDisplay[index].palabraIngles),
              palabra: wordsToDisplay[index],
              onCorrectPronunciation: (learnedWord) {
                if (!showLearnedWords) {
                  setState(() {
                    palabrasLeccion.remove(wordsToDisplay[index]);
                    palabrasLeccion.add(learnedWord);
                    _updateFilteredWords(); // Recalcular palabras y páginas
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleButton() {
    return Padding(
      padding: const EdgeInsets.all(AppUtils.buttonPadding),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            showLearnedWords = !showLearnedWords;
            _currentPage = 0; // Reiniciar a la primera página
            _updateFilteredWords(); // Actualizar las palabras y páginas
          });

          // Anunciar cuántas palabras se están mostrando
          SemanticsService.announce(
            "Mostrando ${currentWords.length} palabras",
            TextDirection.ltr,
          );
        },
        child: Text(showLearnedWords
            ? "Mostrar palabras no aprendidas"
            : "Repasar y mostrar palabras aprendidas"),
      ),
    );
  }

  Widget _buildNavigationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Visibility(
          visible: currentWords.isNotEmpty,
          child: TextButton(
            onPressed: _previousPage,
            child: const Text("Anterior", style: TextStyle(fontSize: 18)),
          ),
        ),
        Visibility(
          visible: currentWords.isNotEmpty,
          child: TextButton(
            onPressed: _nextPage,
            child: const Text("Siguiente", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget _buildExitButton() {
    return CustomButton2(
      onPressed: _showExitConfirmationDialog,
      text: Strings.terminarActividad,
    );
  }
}
