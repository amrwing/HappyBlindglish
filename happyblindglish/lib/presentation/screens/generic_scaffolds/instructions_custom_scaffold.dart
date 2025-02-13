import 'package:flutter/material.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';
import 'package:happyblindglish/widgets/custom_button_3.dart';
import 'package:happyblindglish/widgets/widgets.dart';

class InstructionsCustomScaffold extends StatelessWidget {
  final bool returnBottomButtonActivated;
  final String title;
  final Widget? view;
  final String tutorialText;
  final void Function()? onPressedButton1;
  final void Function()? onPressedButton2;
  const InstructionsCustomScaffold(
      {super.key,
      this.returnBottomButtonActivated = false,
      required this.title,
      this.onPressedButton1,
      this.onPressedButton2,
      this.view,
      required this.tutorialText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUtils.generalBackground,
      appBar: AppUtils.customAppBar,
      body: Listener(
        onPointerMove: (PointerMoveEvent event) {},
        onPointerDown: (PointerDownEvent event) {},
        child: Center(
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
                            onPressed: () => Navigator.pop(context),
                            text: Strings.screenBack),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
