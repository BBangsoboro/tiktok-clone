import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/utils.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showinPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showinPage = Page.second;
      });
    } else {
      setState(() {
        _showinPage = Page.first;
      });
    }
  }

  void _onEnterApp() {
    // Navigator.of(context).pushAndRemoveUntil(
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const MainNavigationScreen(),
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
    //   (route) => false,
    // );
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Videos are personalized for you based on what you watch, like and share.",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                ],
              ),
              secondChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text(
                    "Follow the rules!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Take care of one another! Pils!",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                ],
              ),
              crossFadeState: _showinPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isDarkMode(context) ? Colors.black : Colors.white,
          elevation: 0,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _showinPage == Page.first ? 0 : 1,
            child: IgnorePointer(
              ignoring: _showinPage == Page.first,
              child: CupertinoButton(
                  onPressed: _onEnterApp,
                  color: Theme.of(context).primaryColor,
                  child: const Text("Enter the app!",
                      style: TextStyle(
                        color: Colors.white,
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}
