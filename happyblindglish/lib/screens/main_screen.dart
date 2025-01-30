import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happyblindglish/screens/generic_scaffolds/main_custom_scaffold.dart';
import 'package:happyblindglish/utils/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      buttonText1: Strings.navigateToChallenges,
      buttonText2: Strings.watchMyProgress,
      buttonText3: Strings.exit,
      title: Strings.happyBlindglish,
      onPressed1: () => Navigator.pushNamed(context, "pantalla_retos"),
      onPressed2: () => Navigator.pushNamed(context, "pantalla_mi_progreso"),
      onPressed3: () => exit(0),
    );
  }
}
