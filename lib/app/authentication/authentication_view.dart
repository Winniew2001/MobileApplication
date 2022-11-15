import 'package:mobile_application/app/components/auth_switch_button.dart';
import 'package:mobile_application/app/authentication/signin/signin.dart';
import 'package:mobile_application/app/authentication/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/components/slide_fade_switcher.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _showSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 30.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: _showSignIn
                ? const Text("Welcome Back")
                : const Text("Sign Up"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
          child: SlideFadeSwitcher(
            child: _showSignIn ? const SignIn() : const SignUp(),
          ),
        ),
        AuthSwitchButton(
            showSignIn: _showSignIn,
            onTap: () {
              setState(() {
                _showSignIn = !_showSignIn;
              });
            })
      ]),
    );
  }
}
