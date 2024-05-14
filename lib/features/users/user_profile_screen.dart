import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/settings/settings_screen.dart';
import 'package:tictok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tictok_clone/features/users/widgets/user_profile_info.dart';
import 'package:tictok_clone/features/utils.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SettingsScreen(),
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
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.tab == "likes" ? 1 : 0,
        length: 2,
        child: NestedScrollView(
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.zero,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 14),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 14,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        placeholder: 'assets/images/placeholder.jpg',
                        image: 'https://source.unsplash.com/random/?$index',
                      ),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text("Page Two"),
              ),
            ],
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                title: Text(widget.username),
                actions: [
                  IconButton(
                    onPressed: _onGearPressed,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.v6,
                    const CircleAvatar(
                      radius: 50,
                      foregroundColor: Colors.teal,
                      foregroundImage:
                          AssetImage('assets/images/BBansoboro.jpg'),
                      child: Text("BBangSoboro"),
                    ),
                    Gaps.v6,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "@${widget.username}",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode(context)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.lightBlue.shade200,
                          size: Sizes.size14,
                        )
                      ],
                    ),
                    Gaps.v12,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const UserProfileInfo(
                            value: "37",
                            text: "Following",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade200,
                            indent: Sizes.size10,
                            endIndent: Sizes.size10,
                          ),
                          const UserProfileInfo(
                            value: "10.5M",
                            text: "Followers",
                          ),
                          VerticalDivider(
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            color: Colors.grey.shade200,
                            indent: Sizes.size10,
                            endIndent: Sizes.size10,
                          ),
                          const UserProfileInfo(
                            value: "149.3M",
                            text: "Likes",
                          ),
                        ],
                      ),
                    ),
                    Gaps.v12,
                    FractionallySizedBox(
                      widthFactor: 0.33,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Sizes.size2),
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                      ),
                      child: Text(
                          "All highlights and where to watch live matches on FIFA + I wonder how it would look",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                    Gaps.v10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size14,
                        ),
                        Gaps.h12,
                        Text("https://www.fifa.com/fifaplus/en/home",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge),
                      ],
                    ),
                    Gaps.v5,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
