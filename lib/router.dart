import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/authentication/log_in_screen.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/inbox/activity_screen.dart';
import 'package:tictok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tictok_clone/features/videos/views/video_record_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LogInScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: LogInScreen.routeName,
        path: LogInScreen.routeURL,
        builder: (context, state) => const LogInScreen(),
      ),
      GoRoute(
        name: InterestsScreen.routeName,
        path: InterestsScreen.routeURL,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const InterestsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(
                    CurveTween(
                      curve: Curves.ease,
                    ),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: MainNavigationScreen.routeName,
        path: "/:tab(home|discover|inbox|profile)",
        builder: (context, state) {
          final tab = state.params['tab']!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: ActivityScreen.routeName,
        path: ActivityScreen.routeURL,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ActivityScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(
                    CurveTween(
                      curve: Curves.ease,
                    ),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: ChatsScreen.routeName,
        path: ChatsScreen.routeURL,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ChatsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(
                    CurveTween(
                      curve: Curves.ease,
                    ),
                  ),
                ),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            name: ChatDetailScreen.routeName,
            path: ChatDetailScreen.routeURL,
            pageBuilder: (context, state) {
              final chatId = state.params['chatId']!;
              return CustomTransitionPage(
                child: ChatDetailScreen(chatId: chatId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(1.0, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).chain(
                        CurveTween(
                          curve: Curves.ease,
                        ),
                      ),
                    ),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
      GoRoute(
        name: VideoRecordingScreen.routeName,
        path: VideoRecordingScreen.routeURL,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 200),
            child: const VideoRecordingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                  Tween(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).chain(
                    CurveTween(
                      curve: Curves.ease,
                    ),
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
});

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       name: SignUpScreen.routeName,
//       path: SignUpScreen.routeURL,
//       builder: (context, state) => const SignUpScreen(),
//       routes: [
//         GoRoute(
//           name: UsernameScreen.routeName,
//           path: UsernameScreen.routeURL,
//           pageBuilder: (context, state) {
//             return CustomTransitionPage(
//               child: const UsernameScreen(),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 var curve = Curves.ease;
//                 var curveTween = CurveTween(curve: curve);

//                 const begin = Offset(1.0, 0.0);
//                 const end = Offset(0.0, 0.0);

//                 final tween = Tween(begin: begin, end: end).chain(curveTween);

//                 return SlideTransition(
//                     position: animation.drive(tween), child: child);
//               },
//             );
//           },
//           routes: [
//             GoRoute(
//               name: EmailScreen.routeName,
//               path: EmailScreen.routeURL,
//               builder: (context, state) {
//                 final args = state.extra as EmailScreenParams;
//                 return EmailScreen(username: args.username);
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           name: LogInScreen.routeName,
//           path: LogInScreen.routeName,
//           builder: (context, state) => const LogInScreen(),
//         ),
//       ],
//     ),
//     GoRoute(
//       path: InterestsScreen.routeName,
//       builder: (context, state) => const InterestsScreen(),
//     ),
//     GoRoute(
//       path: TutorialScreen.routeName,
//       builder: (context, state) => const TutorialScreen(),
//     ),
//     GoRoute(
//       path: MainNavigationScreen.routeName,
//       builder: (context, state) => const MainNavigationScreen(),
//     ),
//     GoRoute(
//       path: "/users/:username",
//       builder: (context, state) {
//         final String? username = state.params['username'];
//         final tab = state.queryParams["show"];
//         return UserProfileScreen(username: username!, tab: tab!);
//       },
//     ),
//   ],
// );
