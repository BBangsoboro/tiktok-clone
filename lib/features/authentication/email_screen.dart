import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/password_screen.dart';
import 'package:tictok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class EmailScreenParams {
  final String username;

  EmailScreenParams({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;
  const EmailScreen({super.key, required this.username});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_email.isEmpty) return;

    // Navigator.of(context).push(PageRouteBuilder(
    //   pageBuilder: (context, animation, secondaryAnimation) =>
    //       const EmailScreen(),
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //     var curve = Curves.ease;
    //     var curveTween = CurveTween(curve: curve);

    //     const begin = Offset(1.0, 0.0);
    //     const end = Offset(0.0, 0.0);

    //     final tween = Tween(begin: begin, end: end).chain(curveTween);

    //     return SlideTransition(position: animation.drive(tween), child: child);
    //   },
    // ));
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regExp.hasMatch(_email)) {
      return "Email Not Valid";
    }

    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;

    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "email": _email};

    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween(
                    begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                .chain(CurveTween(curve: Curves.ease));

            return SlideTransition(
                position: animation.drive(tween), child: child);
          },
        ));
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
              Text(
                "What is your email?, ${widget.username}",
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v28,
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      controller: _emailController,
                      cursorColor: Theme.of(context).primaryColor,
                      onEditingComplete: _onSubmit,
                      decoration: InputDecoration(
                        hintText: "Email",
                        errorText: _isEmailValid(),
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
                        fontSize: Sizes.size20,
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
                      onTap: _onSubmit,
                      child: FormButton(
                        disabled: _email.isEmpty || _isEmailValid() != null,
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
