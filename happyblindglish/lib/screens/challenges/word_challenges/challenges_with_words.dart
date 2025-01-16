import 'package:flutter/material.dart';

import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class ChallengesWithWords extends StatelessWidget {
  const ChallengesWithWords({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainCustomScaffold(
      title: "RETOS CON PALABRAS",
      buttonText1: "BASICOS\n APRENDER 30 PALABRAS AL DÍA",
      buttonText2: "INTERMEDIO\n APRENDER 50 PALABRAS AL DÍA",
      buttonText3: "AVANZADO\n APRENDER 100 PALABRAS AL DÍA",
      returnBottomButtonActivated: true,
    );
  }
}
