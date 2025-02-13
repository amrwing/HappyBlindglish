import 'package:flutter/material.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';

class ProgressScreen extends StatelessWidget {
  final String text;
  const ProgressScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      tutorialText: text,
      title: "MI PROGRESO",
      buttonText1: "PALABRAS APRENDIDAS",
      buttonText2: "PUNTOS ACTUALES",
      buttonText3: "MEJOR RACHA",
      returnBottomButtonActivated: true,
    );
  }
}
