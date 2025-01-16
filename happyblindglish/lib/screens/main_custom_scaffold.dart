import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/widgets/custom_button_1.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';

class MainCustomScaffold extends StatelessWidget {
  final String title;
  final String? buttonText1;
  final String? buttonText2;
  final String? buttonText3;
  final bool returnBottomButtonActivated;
  final void Function()? onPressed1;
  final void Function()? onPressed2;
  final void Function()? onPressed3;
  const MainCustomScaffold(
      {super.key,
      required this.title,
      this.onPressed1,
      this.onPressed2,
      this.onPressed3,
      this.buttonText1,
      this.buttonText2,
      this.buttonText3,
      this.returnBottomButtonActivated = false});

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
                buttonText1 != null && buttonText1!.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: AppUtils.buttonPadding),
                        child: CustomButton1(
                          onPressed: onPressed1,
                          text: buttonText1!,
                        ),
                      )
                    : const SizedBox.shrink(),
                buttonText2 != null && buttonText2!.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: AppUtils.buttonPadding),
                        child: CustomButton1(
                          onPressed: onPressed2,
                          text: buttonText2!,
                        ),
                      )
                    : const SizedBox.shrink(),
                buttonText3 != null && buttonText3!.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: AppUtils.buttonPadding),
                        child: CustomButton1(
                          onPressed: onPressed3,
                          text: buttonText3!,
                        ),
                      )
                    : const SizedBox.shrink(),
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
