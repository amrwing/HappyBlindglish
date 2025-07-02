import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
    return Semantics(
      excludeSemantics: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
