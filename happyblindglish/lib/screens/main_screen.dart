import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      buttonText1: "NAVEGAR A RETOS",
      buttonText2: "VER MI PROGRESO",
      buttonText3: "SALIR",
      title: "HAPPY BLINDGLISH",
      onPressed1: () => context.go("/challenges_main_screen"),
    );
  }
}
