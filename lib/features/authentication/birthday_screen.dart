import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  final DateTime _initialDate = DateTime.now();
  //DateTime maxDate = DateTime.now().add(const Duration(days: -(365 * 12)));

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(_initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const InterestsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = Curves.ease;
          var curveTween = CurveTween(curve: curve);

          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);

          final tween = Tween(begin: begin, end: end).chain(curveTween);

          return SlideTransition(
              position: animation.drive(tween), child: child);
        },
      ),
      (route) => false,
    );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Stack(
          children: [
            FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: Sizes.size20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sign up',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What's your birthday?",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "Your birthday won't be shown publicly.",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                FaIcon(FontAwesomeIcons.cakeCandles),
              ],
            ),
            Gaps.v28,
            Form(
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: Sizes.size16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                    ),
                    showCursor: true,
                    onSaved: (newValue) => {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Gaps.v36,
                  GestureDetector(
                    onTap: _onNextTap,
                    child: const FormButton(
                      disabled: false,
                      text: "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          maximumDate: _initialDate,
          initialDateTime: _initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
