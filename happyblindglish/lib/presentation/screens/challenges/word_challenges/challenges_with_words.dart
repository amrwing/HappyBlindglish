import 'package:flutter/material.dart';

import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';

class ChallengesWithWords extends StatelessWidget {
  final String text;
  const ChallengesWithWords({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      title: "RETOS CON PALABRAS",
      buttonText1: "BASICOS\n APRENDER 30 PALABRAS AL DÍA",
      buttonText2: "INTERMEDIO\n APRENDER 50 PALABRAS AL DÍA",
      buttonText3: "AVANZADO\n APRENDER 100 PALABRAS AL DÍA",
      returnBottomButtonActivated: true,
      tutorialText: text,
    );
  }
}
