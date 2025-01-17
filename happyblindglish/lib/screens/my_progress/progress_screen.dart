import 'package:flutter/material.dart';
import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainCustomScaffold(
      title: "MI PROGRESO",
      buttonText1: "PALABRAS APRENDIDAS",
      buttonText2: "PUNTOS ACTUALES",
      buttonText3: "MEJOR RACHA",
      returnBottomButtonActivated: true,
    );
  }
}
