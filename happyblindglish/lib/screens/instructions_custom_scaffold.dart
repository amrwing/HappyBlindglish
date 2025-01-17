import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';
import 'package:happyblindglish/widgets/custom_button_3.dart';
import 'package:happyblindglish/widgets/widgets.dart';

class InstructionsCustomScaffold extends StatelessWidget {
  final bool returnBottomButtonActivated;
  final String title;
  final void Function()? onPressedButton1;
  final void Function()? onPressedButton2;
  const InstructionsCustomScaffold(
      {super.key,
      this.returnBottomButtonActivated = false,
      required this.title,
      this.onPressedButton1,
      this.onPressedButton2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.customAppBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppUtils.generalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MergeSemantics(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: AppUtils.titleFontSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppUtils.buttonPadding),
                child: CustomButton1(
                  onPressed: onPressedButton1,
                  text: Strings.instructions,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppUtils.buttonPadding),
                child: CustomButton3(
                  onPressed: onPressedButton2,
                  text: Strings.startChallenge,
                ),
              ),
              returnBottomButtonActivated
                  ? Padding(
                      padding: const EdgeInsets.all(AppUtils.buttonPadding),
                      child: CustomButton2(
                          onPressed: () => context.pop(),
                          text: Strings.screenBack),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
