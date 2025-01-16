import 'package:flutter/material.dart';

import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class ChallengesWithLetters extends StatelessWidget {
  const ChallengesWithLetters({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainCustomScaffold(
      title: "RETOS CON LETRAS",
      buttonText1: "RETO IDENTIFICAR",
      buttonText2: "RETO: PRONUNCIAR",
      returnBottomButtonActivated: true,
    );
  }
}
