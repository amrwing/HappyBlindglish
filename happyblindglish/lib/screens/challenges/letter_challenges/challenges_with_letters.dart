import 'package:flutter/material.dart';
import 'package:happyblindglish/screens/generic_scaffolds/main_custom_scaffold.dart';

class ChallengesWithLetters extends StatelessWidget {
  const ChallengesWithLetters({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      title: "RETOS CON LETRAS",
      buttonText1: "RETO: IDENTIFICAR",
      buttonText2: "RETO: PRONUNCIAR",
      returnBottomButtonActivated: true,
      onPressed1: () =>
          Navigator.pushNamed(context, "pantalla_reto_con_letras_1"),
      onPressed2: () =>
          Navigator.pushNamed(context, "pantalla_reto_con_letras_2"),
    );
  }
}
