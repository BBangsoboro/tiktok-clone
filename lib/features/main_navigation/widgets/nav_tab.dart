import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class NavTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final String label;
  final Function onTap;

  const NavTab({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.6,
          duration: const Duration(milliseconds: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(isSelected ? selectedIcon : icon, color: Colors.white),
              Gaps.v5,
              if (label.isNotEmpty)
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
