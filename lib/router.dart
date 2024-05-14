import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/email_screen.dart';
import 'package:tictok_clone/features/authentication/log_in_screen.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';
import 'package:tictok_clone/features/users/widgets/user_profile_info.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          name: UsernameScreen.routeName,
          path: UsernameScreen.routeURL,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const UsernameScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var curve = Curves.ease;
                var curveTween = CurveTween(curve: curve);

                const begin = Offset(1.0, 0.0);
                const end = Offset(0.0, 0.0);

                final tween = Tween(begin: begin, end: end).chain(curveTween);

                return SlideTransition(
                    position: animation.drive(tween), child: child);
              },
            );
          },
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as EmailScreenParams;
                return EmailScreen(username: args.username);
              },
            ),
          ],
        ),
        GoRoute(
          name: LogInScreen.routeName,
          path: LogInScreen.routeName,
          builder: (context, state) => const LogInScreen(),
        ),
      ],
    ),
    // GoRoute(
    //   name: LogInScreen.routeName,
    //   path: LogInScreen.routeName,
    //   builder: (context, state) => const LogInScreen(),
    // ),
    // GoRoute(
    //   name: "username_screen",
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         var curve = Curves.ease;
    //         var curveTween = CurveTween(curve: curve);

    //         const begin = Offset(1.0, 0.0);
    //         const end = Offset(0.0, 0.0);

    //         final tween = Tween(begin: begin, end: end).chain(curveTween);

    //         return SlideTransition(
    //             position: animation.drive(tween), child: child);
    //       },
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: EmailScreen.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as EmailScreenParams;
    //     return EmailScreen(username: args.username);
    //   },
    // ),
    GoRoute(
      path: InterestsScreen.routeName,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: TutorialScreen.routeName,
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      path: MainNavigationScreen.routeName,
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final String? username = state.params['username'];
        final tab = state.queryParams["show"];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    ),
  ],
);
