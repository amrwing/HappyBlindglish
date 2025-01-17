import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/main_custom_scaffold.dart';
import 'package:happyblindglish/utils/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      buttonText1: Strings.navigateToChallenges,
      buttonText2: Strings.watchMyProgress,
      buttonText3: Strings.exit,
      title: Strings.happyBlindglish,
      onPressed1: () => context.go("/challenges_main_screen"),
      onPressed2: () => context.go("/my_progress_screen"),
      onPressed3: () => exit(0),
    );
  }
}
