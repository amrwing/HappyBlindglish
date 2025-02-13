import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/presentation/blocs/tutorial_preference.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/main_custom_scaffold.dart';

class MainTutorialScreen extends StatelessWidget {
  final String text;
  const MainTutorialScreen({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      forceTutorial: true,
      tutorialText: text,
      title: "INICIO",
      buttonText1: "EMPEZAR CON TEXTOS GUIA",
      buttonText3: "EMPEZAR SIN TEXTOS GUIA",
      onPressed1: () {
        context.read<TutorialPreferenceCubit>().toggleTutorialActivated(true);
        Navigator.pushNamed(context, "pantalla_principal");
      },
      onPressed3: () {
        context.read<TutorialPreferenceCubit>().toggleTutorialActivated(false);
        Navigator.pushNamed(context, "pantalla_principal");
      },
    );
  }
}
