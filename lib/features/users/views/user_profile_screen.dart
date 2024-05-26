import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/settings/settings_screen.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/view_models/user_view_model.dart';
import 'package:tictok_clone/features/users/widgets/avatar.dart';
import 'package:tictok_clone/features/users/widgets/edit_bio_link.dart';
import 'package:tictok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tictok_clone/features/users/widgets/user_profile_info.dart';
import 'package:tictok_clone/features/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
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

  Future<void> _onUpdateBioLink(UserProfileModel data) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          EditBioLinkBottomSheet(bio: data.bio, link: data.link),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          data: (data) => SafeArea(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                              image:
                                  "https://i.pinimg.com/originals/12/bf/1a/12bf1a22bdd03cb2a2b850dcf3f17dd5.jpg",
                              //image: 'https://source.unsplash.com/random/?$index',
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
                      title: Text(data.username),
                      actions: [
                        IconButton(
                          padding: const EdgeInsets.only(
                            left: Sizes.size20,
                          ),
                          onPressed: () => _onUpdateBioLink(data),
                          icon: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            size: Sizes.size20,
                          ),
                        ),
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
                          Avatar(
                            name: data.username,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          Gaps.v6,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "@${data.username}",
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
                                borderRadius:
                                    BorderRadius.circular(Sizes.size2),
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
                            child: Text(data.bio,
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
                              Text(data.link,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
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
          ),
        );
  }
}
