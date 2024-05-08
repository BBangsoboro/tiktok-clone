import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.5),
          title: Row(
            children: [
              IconButton(
                onPressed: () => {},
                icon: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Colors.grey.shade800,
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
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
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
                              color: Colors.grey.shade800,
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
                              color: Colors.grey.shade700,
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
            labelColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Sizes.size8,
                    mainAxisSpacing: Sizes.size8,
                    childAspectRatio: 9 / 21),
                itemBuilder: (context, index) => Column(
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
                          image: 'https://source.unsplash.com/random/?$index',
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
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.shade600,
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
