import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/discover/discover_screen.dart';
import 'package:tictok_clone/features/inbox/inbox_screen.dart';
import 'package:tictok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tictok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tictok_clone/features/users/views/user_profile_screen.dart';
import 'package:tictok_clone/features/utils.dart';
import 'package:tictok_clone/features/videos/views/video_record_screen.dart';
import 'package:tictok_clone/features/videos/views/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = ["home", "discover", "xxxx", "inbox", "profile"];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    // Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
    //       appBar: AppBar(title: const Text('Record Video')),
    //     ),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       var curve = Curves.ease;
    //       var curveTween = CurveTween(curve: curve);

    //       const begin = Offset(1.0, 0.0);
    //       const end = Offset(0.0, 0.0);

    //       final tween = Tween(begin: begin, end: end).chain(curveTween);

    //       return SlideTransition(
    //           position: animation.drive(tween), child: child);
    //     },
    //     fullscreenDialog: true,
    //   ),
    // );
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "bbangsoboro",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.grey.shade900 : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                label: "Home",
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                label: "Discover",
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              PostVideoButton(
                onTap: _onPostVideoButtonTap,
                inverted: _selectedIndex != 0,
              ),
              Gaps.h24,
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
                label: "Inbox",
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                label: "Profile",
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
