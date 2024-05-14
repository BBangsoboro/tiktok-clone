import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/email_screen.dart';
import 'package:tictok_clone/features/authentication/log_in_screen.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/utils.dart';
import 'package:flutter_gen/gen_l10n/intl_generated.dart';

class SignUpScreen extends StatelessWidget {
  static String routeURL = "/";
  static String routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLogInTap(BuildContext context) async {
    // 버전 1 방식
    // final result = await Navigator.of(context).push(PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) =>
    //       const LogInScreen(),
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     var curve = Curves.ease;
    //     var curveTween = CurveTween(curve: curve);

    //     const begin = Offset(1.0, 0.0);
    //     const end = Offset(0.0, 0.0);

    //     final tween = Tween(begin: begin, end: end).chain(curveTween);

    //     return SlideTransition(position: animation.drive(tween), child: child);
    //   },
    // ));
    // print(result);

    // final result = Navigator.of(context).pushNamed(LogInScreen.routeName);
    // print(result);

    // 버전 2 방식
    context.pushNamed(LogInScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       var curve = Curves.ease;
    //       var curveTween = CurveTween(curve: curve);

    //       const begin = Offset(1.0, 0.0);
    //       const end = Offset(0.0, 0.0);

    //       final tween = Tween(begin: begin, end: end).chain(curveTween);

    //       return SlideTransition(
    //           position: animation.drive(tween), child: child);
    //     },
    //   ),
    // );
    // Navigator.of(context).pushNamed(UsernameScreen.routeName);

    context.pushNamed(UsernameScreen.routeName);
    //context.go('/users/lynn?show=likes');
  }

  void _onAppleTap(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const EmailScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       var curve = Curves.ease;
    //       var curveTween = CurveTween(curve: curve);

    //       const begin = Offset(1.0, 0.0);
    //       const end = Offset(0.0, 0.0);

    //       final tween = Tween(begin: begin, end: end).chain(curveTween);

    //       return SlideTransition(
    //           position: animation.drive(tween), child: child);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text("plz rotate ur phone."),
        //     ),
        //   );
        // }
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Gaps.v80,
                      Text(
                        AppLocalizations.of(context)!.signUpTitle("TicTok"),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Gaps.v20,
                      const Opacity(
                        opacity: 0.7,
                        child: Text(
                          "Create a profile, follow other accounts, make your own videos, and more.",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v40,
                      if (orientation == Orientation.portrait) ...[
                        AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.user),
                          text: "Use email & password",
                          onTap: () => _onEmailTap(context),
                        ),
                        Gaps.v16,
                        AuthButton(
                          icon: const FaIcon(FontAwesomeIcons.apple),
                          text: "Continue with Apple",
                          onTap: () => _onAppleTap(context),
                        ),
                        Gaps.v16,
                        const FaIcon(
                          FontAwesomeIcons.chevronDown,
                          size: Sizes.size20,
                        ),
                      ],
                      if (orientation == Orientation.landscape)
                        Row(
                          children: [
                            Expanded(
                              child: AuthButton(
                                icon: const FaIcon(FontAwesomeIcons.user),
                                text: "Use email & password",
                                onTap: () => _onEmailTap(context),
                              ),
                            ),
                            Gaps.h16,
                            Expanded(
                              child: AuthButton(
                                icon: const FaIcon(FontAwesomeIcons.apple),
                                text: "Continue with Apple",
                                onTap: () => _onAppleTap(context),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: Sizes.size20,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey.shade500),
                        text: "By continuing, you agree to our ",
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: isDarkMode(context)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                              text: " and acknowledge that you have read our "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: isDarkMode(context)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  " to learn how we collect, use, and share your data.")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: Sizes.size16),
                ),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLogInTap(context),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
