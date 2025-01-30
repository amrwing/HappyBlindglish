import 'package:flutter/widgets.dart';
import 'package:happyblindglish/screens/generic_scaffolds/instructions_custom_scaffold.dart';

class LetterChallenge2 extends StatelessWidget {
  const LetterChallenge2({super.key});

  @override
  Widget build(BuildContext context) {
    return const InstructionsCustomScaffold(
      title: "RETO: PRONUNCIAR",
      returnBottomButtonActivated: true,
    );
  }
}
