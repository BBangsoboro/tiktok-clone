import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tictok_clone/features/onboarding/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  static String routeName = "/interests";
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  final GlobalKey _showTitleTargetKey = GlobalKey();
  final GlobalKey _appBarKey = GlobalKey();

  void _onScroll() {
    final RenderBox renderBox =
        _showTitleTargetKey.currentContext!.findRenderObject()! as RenderBox;
    final targetPosition = renderBox.localToGlobal(Offset.zero);
    final appBarSize =
        (_appBarKey.currentContext!.findRenderObject()! as RenderBox)
            .size
            .height;
    final position = targetPosition.dy - appBarSize;

    if (position < 0) {
      if (_showTitle == true) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      if (_showTitle == false) return;
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    // Navigator.of(context).push(PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) =>
    //       const TutorialScreen(),
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     var curve = Curves.ease;
    //     var curveTween = CurveTween(curve: curve);

    //     const begin = Offset(1.0, 0.0);
    //     const end = Offset(0.0, 0.0);

    //     final tween = Tween(begin: begin, end: end).chain(curveTween);

    //     return SlideTransition(position: animation.drive(tween), child: child);
    //   },
    // ));
    context.go(TutorialScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _appBarKey,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: const Text('Choose your interests'),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "Get better video recommendations",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                SizedBox(
                  key: _showTitleTargetKey,
                ),
                Gaps.v64,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (var interest in interests)
                      InterestButton(interest: interest)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: GestureDetector(
          onTap: _onNextTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2)),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
