import 'package:mobile_application/app/components/auth_switch_button.dart';
import 'package:mobile_application/app/authentication/signin/signin.dart';
import 'package:mobile_application/app/authentication/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/app/components/slide_fade_switcher.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
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
            child: _showSignIn ? Text("Welcome Back") : Text("Sign Up"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
          child: SlideFadeSwitcher(
            child: _showSignIn ? SignIn() : SignUp(),
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
