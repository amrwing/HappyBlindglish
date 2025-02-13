import 'package:flutter/widgets.dart';
import 'package:happyblindglish/presentation/screens/generic_scaffolds/instructions_custom_scaffold.dart';

class LetterChallenge2 extends StatelessWidget {
  final String text;
  const LetterChallenge2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InstructionsCustomScaffold(
      tutorialText: text,
      title: "RETO: PRONUNCIAR",
      returnBottomButtonActivated: true,
    );
  }
}
