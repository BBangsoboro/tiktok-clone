import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/utils.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final String label;
  final Function onTap;
  final int selectedIndex;

  const NavTab({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.6,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0
                      ? Colors.white
                      : isDarkMode(context)
                          ? Colors.white
                          : Colors.black,
                ),
                Gaps.v5,
                if (label.isNotEmpty)
                  Text(
                    label,
                    style: TextStyle(
                      color: selectedIndex == 0
                          ? Colors.white
                          : isDarkMode(context)
                              ? Colors.white
                              : Colors.black,
                      fontSize: Sizes.size12,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
