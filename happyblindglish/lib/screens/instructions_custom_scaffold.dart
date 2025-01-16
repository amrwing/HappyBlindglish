import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/utils/app_utils.dart';
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
    return MergeSemantics(
      child: Scaffold(
        appBar: AppUtils.customAppBar,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppUtils.generalPadding),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppUtils.buttonPadding),
                  child: CustomButton1(
                    onPressed: onPressedButton1,
                    text: "INSTRUCCIONES",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppUtils.buttonPadding),
                  child: CustomButton3(
                    onPressed: onPressedButton2,
                    text: "COMENZAR RETO",
                  ),
                ),
                returnBottomButtonActivated
                    ? Padding(
                        padding: const EdgeInsets.all(AppUtils.buttonPadding),
                        child: CustomButton2(
                            onPressed: () => context.pop(), text: "REGRESAR"),
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
