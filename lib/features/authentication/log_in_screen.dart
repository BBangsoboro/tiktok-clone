import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/login_form_screen.dart';
import 'package:tictok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogInScreen extends ConsumerWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LogInScreen({super.key});

  void onSignUpTap(BuildContext context) {
    // 버전 1 방식
    //Navigator.of(context).pop();
    // 버전 2 방식
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginFormScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var curve = Curves.ease;
            var curveTween = CurveTween(curve: curve);

            const begin = Offset(1.0, 0.0);
            const end = Offset(0.0, 0.0);

            final tween = Tween(begin: begin, end: end).chain(curveTween);

            return SlideTransition(
                position: animation.drive(tween), child: child);
          },
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Log in to TikTok",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications. comment on videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailLoginTap(context),
                child: const AuthButton(
                  icon: FaIcon(FontAwesomeIcons.user),
                  text: "Use email & password",
                ),
              ),
              Gaps.v16,
              const AuthButton(
                icon: FaIcon(FontAwesomeIcons.apple),
                text: "Continue with Apple",
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => ref
                    .read(socialLoginProvider.notifier)
                    .githubSignIn(context),
                child: const AuthButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  text: "Continue with Github",
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: Sizes.size16,
              ),
            ),
            GestureDetector(
              onTap: () => onSignUpTap(context),
              child: Text(
                "Sign up",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                    fontSize: Sizes.size16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
