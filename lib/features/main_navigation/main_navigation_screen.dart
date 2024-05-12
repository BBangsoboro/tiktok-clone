import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/discover/discover_screen.dart';
import 'package:tictok_clone/features/inbox/inbox_screen.dart';
import 'package:tictok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tictok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';
import 'package:tictok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
          appBar: AppBar(title: const Text('Record Video')),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.ease;
          var curveTween = CurveTween(curve: curve);

          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);

          final tween = Tween(begin: begin, end: end).chain(curveTween);

          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
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
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 0 ? Colors.black : Colors.white,
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
