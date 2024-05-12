import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';

class UserProfileInfo extends StatelessWidget {
  final String value;
  final String text;

  const UserProfileInfo({super.key, required this.value, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: Sizes.size14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
