import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/birthday_screen.dart';
import 'package:tictok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  PasswordScreenState createState() => PasswordScreenState();
}

class PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_password.isEmpty) return;

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PasswordScreen(),
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

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "password": _password,
    };

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const BirthdayScreen(),
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

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
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
              Opacity(
                opacity: 0.7,
                child: IconButton(
                  onPressed: () => {},
                  icon: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    color: Colors.grey.shade500,
                  ),
                ),
              )
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
              const Text(
                "Create Password",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v28,
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      obscureText: _obscureText,
                      controller: _passwordController,
                      onEditingComplete: _onSubmit,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _onClearTap,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                size: Sizes.size16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.h14,
                            GestureDetector(
                              onTap: _toggleObscureText,
                              child: FaIcon(
                                _obscureText
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: Sizes.size16,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.h14,
                          ],
                        ),
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
                    Gaps.v10,
                    const Text(
                      'Your password must have:',
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v10,
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleCheck,
                          color: _isPasswordValid()
                              ? Colors.green
                              : Colors.grey.shade400,
                          size: Sizes.size18,
                        ),
                        Gaps.h4,
                        Text(
                          "8 to 20 characters",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Sizes.size12,
                          ),
                        )
                      ],
                    ),
                    Gaps.v4,
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleCheck,
                          color: _isPasswordValid()
                              ? Colors.green
                              : Colors.grey.shade400,
                          size: Sizes.size18,
                        ),
                        Gaps.h4,
                        Text(
                          "Letters, numbers, and special characters",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Sizes.size12,
                          ),
                        )
                      ],
                    ),
                    Gaps.v36,
                    GestureDetector(
                      onTap: _onSubmit,
                      child: FormButton(
                        disabled: !_isPasswordValid(),
                        text: "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
