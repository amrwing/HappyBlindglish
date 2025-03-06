import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:happyblindglish/widgets/custom_button_1.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Crear claves globales para cada página del onboarding
  final List<GlobalKey<OnboardingPageState>> _pageKeys = [
    GlobalKey<OnboardingPageState>(),
    GlobalKey<OnboardingPageState>(),
    GlobalKey<OnboardingPageState>(),
    GlobalKey<OnboardingPageState>(),
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      Navigator.pushReplacementNamed(context, "pantalla_principal");
    }
  }

  void _backPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }

    // Llamar a la acción dentro de la página actual
    _pageKeys[_currentPage].currentState?.executeAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                OnboardingPage(
                  key: _pageKeys[0],
                  title: "Bienvenido a HappyBlindglish",
                  description:
                      "Presiona \"Siguiente\" para descubrir qué podrás hacer en HappyBlindglish",
                ),
                OnboardingPage(
                  key: _pageKeys[1],
                  title: "Aprende",
                  description:
                      "a través de lecciones tematicas e interactivas para prepararte a realizar los retos diarios. Podrás utilizar las lecciones las veces que necesites",
                ),
                OnboardingPage(
                  key: _pageKeys[2],
                  title: "Completa retos diarios",
                  description:
                      "poniendo a prueba tus conocimientos en inglés para ganar puntos y desbloquear nuevos niveles",
                ),
                OnboardingPage(
                  key: _pageKeys[3],
                  title: "Diviertete",
                  description:
                      "Cuando estés listo para empezar, presiona \"Comenzar\" y serás redirigido a la pantalla principal",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Visibility(
                  visible: _currentPage > 0,
                  child: CustomButton1(onPressed: _backPage, text: "Anterior"),
                ),
                CustomButton1(
                    onPressed: _nextPage,
                    text: _currentPage == 2 ? "Comenzar" : "Siguiente"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback? onButtonPressed; // Nueva función callback opcional

  const OnboardingPage({
    required this.title,
    required this.description,
    this.onButtonPressed, // Parámetro opcional
    super.key,
  });

  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Anuncia el título para TalkBack o VoiceOver
      _readTexts();
    });
  }

  void executeAction() {
    // Aquí se ejecuta cualquier acción cuando se presione el botón en OnboardingScreen
    _readTexts();
  }

  void _readTexts() {
    SemanticsService.announce(
        "${widget.title} ${widget.description}", TextDirection.ltr);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Semantics(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Semantics(
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
