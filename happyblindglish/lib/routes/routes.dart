import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/challenges/challenges_main_screen.dart';
import 'package:happyblindglish/screens/challenges/letter_challenges/challenges_with_letters.dart';
import 'package:happyblindglish/screens/challenges/letter_challenges/letter_challenge_1.dart';
import 'package:happyblindglish/screens/challenges/word_challenges/challenges_with_words.dart';
import 'package:happyblindglish/screens/my_progress/progress_screen.dart';
import 'package:happyblindglish/screens/screens.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MainScreen(),
      routes: [
        GoRoute(
            path: "challenges_main_screen",
            builder: (context, state) => const ChallengesMainScreen(),
            routes: [
              GoRoute(
                  path: "challenges_with_letters",
                  builder: (context, state) => const ChallengesWithLetters(),
                  routes: [
                    GoRoute(
                      path: "letter_challenge_1",
                      builder: (context, state) => const LetterChallenge1(),
                    ), //TODO
                    // GoRoute(path: "letter_challenge_2"), //TODO
                  ]),
              GoRoute(
                  path: "challenges_with_words",
                  builder: (context, state) => const ChallengesWithWords(),
                  routes: [
                    //GoRoute(path: "single_challenge_1"), //TODO
                    //GoRoute(path: "word_challenge_2"), //TODO
                  ])
            ]),
        GoRoute(
          path: "my_progress_screen",
          builder: (context, state) => const ProgressScreen(),
        )
      ],
    ),
  ]);
}
