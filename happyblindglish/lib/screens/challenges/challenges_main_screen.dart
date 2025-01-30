import 'package:flutter/widgets.dart';
import 'package:happyblindglish/screens/generic_scaffolds/main_custom_scaffold.dart';

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
          Navigator.pushNamed(context, "pantalla_retos_con_letras"),
      onPressed2: () =>
          Navigator.pushNamed(context, "pantalla_retos_con_palabras"),
    );
  }
}
