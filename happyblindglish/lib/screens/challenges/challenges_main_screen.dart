import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/main_custom_scaffold.dart';

class ChallengesMainScreen extends StatelessWidget {
  const ChallengesMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      title: 'RETOS',
      buttonText1: 'RETOS CON LETRAS',
      buttonText2: 'RETOS CON PALABRAS',
      buttonText3: 'RETOS CON FRASES',
      returnBottomButtonActivated: true,
      onPressed1: () =>
          context.go("/challenges_main_screen/challenges_with_letters"),
    );
  }
}
