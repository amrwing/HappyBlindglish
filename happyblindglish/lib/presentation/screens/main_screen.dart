import 'package:flutter/material.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';
import 'package:happyblindglish/utils/constants.dart';

class MainScreen extends StatelessWidget {
  final String text;
  const MainScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      tutorialText: text,
      buttonText1: Strings.navigateToChallenges,
      buttonText2: Strings.watchMyProgress,
      buttonText3: Strings.learnVocabulary,
      title: "PANTALLA PRINCIPAL",
      onPressed1: () => Navigator.pushNamed(context, "retos_del_dia"),
      onPressed2: () => Navigator.pushNamed(context, "pantalla_mi_progreso"),
    );
  }
}
