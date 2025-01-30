import 'package:flutter/widgets.dart';
import 'package:happyblindglish/screens/generic_scaffolds/instructions_custom_scaffold.dart';

class LetterChallenge1 extends StatelessWidget {
  const LetterChallenge1({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstructionsCustomScaffold(
      title: "RETO:IDENTIFICAR",
      returnBottomButtonActivated: true,
    );
  }
}
