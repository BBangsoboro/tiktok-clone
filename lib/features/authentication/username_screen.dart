import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/email_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const EmailScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.ease;
        var curveTween = CurveTween(curve: curve);

        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0, 0.0);

        final tween = Tween(begin: begin, end: end).chain(curveTween);

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skip',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.grey.shade500,
              ),
            ),
            const Text('Sign up'),
            IconButton(
              onPressed: () => {},
              icon: FaIcon(
                FontAwesomeIcons.circleQuestion,
                color: Colors.grey.shade500,
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v10,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.black54,
              ),
            ),
            Gaps.v28,
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      hintText: "Username",
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
                      color: Colors.black,
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
                    child: FormButton(
                      disabled: _username.isEmpty,
                      text: "Next",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
