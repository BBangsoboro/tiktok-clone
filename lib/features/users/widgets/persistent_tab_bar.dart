import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: TabBar(
        dividerColor: Colors.grey.shade200,
        dividerHeight: 0.5,
        labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size12),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: Icon(Icons.grid_4x4_outlined, color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size14),
            child: FaIcon(FontAwesomeIcons.heart),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}