import 'package:flutter/widgets.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/instructions_custom_scaffold.dart';

class LetterChallenge1 extends StatelessWidget {
  final String text;
  const LetterChallenge1({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InstructionsCustomScaffold(
      tutorialText: text,
      title: "RETO:IDENTIFICAR",
      returnBottomButtonActivated: true,
    );
  }
}
