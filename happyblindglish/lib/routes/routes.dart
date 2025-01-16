import 'package:go_router/go_router.dart';
import 'package:happyblindglish/screens/challenges/challenges_main_screen.dart';
import 'package:happyblindglish/screens/challenges/challenges_with_letters.dart';
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
              )
            ]),
      ],
    ),
  ]);
}
