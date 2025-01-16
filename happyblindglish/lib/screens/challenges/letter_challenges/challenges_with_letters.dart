import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class ChallengesWithLetters extends StatelessWidget {
  const ChallengesWithLetters({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      title: "RETOS CON LETRAS",
      buttonText1: "RETO IDENTIFICAR",
      buttonText2: "RETO: PRONUNCIAR",
      returnBottomButtonActivated: true,
      onPressed1: () => context.go(
          "/challenges_main_screen/challenges_with_letters/letter_challenge_1"),
      onPressed2: () => context.go(
          "/challenges_main_screen/challenges_with_letters/letter_challenge_1"), //TODO: CHANGE
    );
  }
}
