import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyblindglish/presentation/blocs/tutorial_preference.dart';
import 'package:happyblindglish/utils/app_utils.dart';
import 'package:happyblindglish/utils/constants.dart';
import 'package:happyblindglish/widgets/custom_button_1.dart';
import 'package:happyblindglish/widgets/custom_button_2.dart';

class MainCustomScaffold extends StatelessWidget {
  final String title;
  final String? buttonText1;
  final bool? forceTutorial;
  final Widget? view;
  final String tutorialText;
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
      this.returnBottomButtonActivated = false,
      this.view,
      required this.tutorialText,
      this.forceTutorial});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        // Captura el evento de toque en la pantalla
        event;
      },
      onPointerMove: (event) {
        event.localPosition;
      },
      child: Scaffold(
        appBar: AppUtils.customAppBar,
        backgroundColor: AppUtils.generalBackground,
        body: BlocBuilder<TutorialPreferenceCubit, bool>(
          builder: (context, state) => Center(
            child: Padding(
                padding: const EdgeInsets.all(AppUtils.generalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MergeSemantics(
                      child: MergeSemantics(
                        child: Text(
                          title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppUtils.titleFontSize,
                          ),
                        ),
                      ),
                    ),
                    view ?? const SizedBox.shrink(),
                    Visibility(
                      visible: state || forceTutorial != null && forceTutorial!,
                      child: Text(
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: AppUtils.guideTextSize),
                          textAlign: TextAlign.justify,
                          tutorialText),
                    ),
                    buttonText1 != null && buttonText1!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: AppUtils.buttonPadding),
                            child: CustomButton1(
                              onPressed: onPressed1,
                              text: buttonText1!,
                            ),
                          )
                        : const SizedBox.shrink(),
                    buttonText2 != null && buttonText2!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: AppUtils.buttonPadding),
                            child: CustomButton1(
                              onPressed: onPressed2,
                              text: buttonText2!,
                            ),
                          )
                        : const SizedBox.shrink(),
                    buttonText3 != null && buttonText3!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: AppUtils.buttonPadding),
                            child: CustomButton1(
                              onPressed: onPressed3,
                              text: buttonText3!,
                            ),
                          )
                        : const SizedBox.shrink(),
                    returnBottomButtonActivated
                        ? Padding(
                            padding:
                                const EdgeInsets.all(AppUtils.buttonPadding),
                            child: CustomButton2(
                                onPressed: () => Navigator.pop(context),
                                text: Strings.screenBack.toUpperCase()),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
