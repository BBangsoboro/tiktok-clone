import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tictok_clone/constants/breakpoints.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/features/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "food tiktok");

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

  void _onTabTapView() {
    FocusScope.of(context).unfocus();
  }

  void _onTabTap(int selectedIndex) {
    FocusScope.of(context).unfocus();
  }

  void _onClearSearch() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.5),
          title: Row(
            children: [
              IconButton(
                onPressed: () => {},
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: isDarkMode(context)
                      ? Colors.grey.shade500
                      : Colors.grey.shade800,
                ),
                iconSize: Sizes.size24,
              ),
              Expanded(
                child: SizedBox(
                  height: Sizes.size40,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: _onSearchChanged,
                    onSubmitted: _onSearchSubmitted,
                    style: TextStyle(
                      color: isDarkMode(context) ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                      ),
                      filled: true,
                      fillColor: isDarkMode(context)
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: _onClearSearch,
                            icon: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: isDarkMode(context)
                                  ? Colors.grey.shade200
                                  : Colors.grey.shade800,
                            ),
                            iconSize: Sizes.size18,
                          ),
                        ],
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: _onClearSearch,
                            icon: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: isDarkMode(context)
                                  ? Colors.grey.shade200
                                  : Colors.grey.shade800,
                            ),
                            iconSize: Sizes.size18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          titleSpacing: Sizes.size6,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: const FaIcon(FontAwesomeIcons.sliders),
              tooltip: "Under Construction",
            )
          ],
          bottom: TabBar(
            onTap: _onTabTap,
            dividerColor: Colors.grey.shade300,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            labelColor: isDarkMode(context) ? Colors.white : Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: isDarkMode(context) ? Colors.white : Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: [for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: GestureDetector(
          onTap: _onTabTapView,
          child: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10,
                  vertical: Sizes.size10,
                ),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                    crossAxisSpacing: Sizes.size8,
                    mainAxisSpacing: Sizes.size8,
                    childAspectRatio: 9 / 21),
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.cover,
                            placeholder: 'assets/images/placeholder.jpg',
                            image:
                                "https://i.pinimg.com/originals/12/bf/1a/12bf1a22bdd03cb2a2b850dcf3f17dd5.jpg",
                            //image: 'https://source.unsplash.com/random/?$index',
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is very long caption for my tiktok that im upload just now currently.",
                        style: TextStyle(
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.v8,
                      if (constraints.maxWidth < 200 ||
                          constraints.maxWidth > 250)
                        DefaultTextStyle(
                          style: TextStyle(
                            color: isDarkMode(context)
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage:
                                    AssetImage("assets/images/BBansoboro.jpg"),
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  "My avatar is goint to be very long",
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size16,
                                color: Colors.grey.shade600,
                              ),
                              Gaps.h2,
                              const Text(
                                '2.5M',
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size48,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
