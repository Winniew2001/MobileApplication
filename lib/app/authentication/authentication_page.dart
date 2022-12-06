import 'package:mobile_application/app/components/auth_switch_button.dart';
import 'package:mobile_application/app/authentication/signin/signin.dart';
import 'package:mobile_application/app/authentication/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application/misc/slide_fade_switcher.dart';

/*
 * Page for displaying authentication options.
 */
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
          padding: const EdgeInsets.fromLTRB(16.0, 80.0, 0.0, 0.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: _showSignIn
                ? const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                : const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
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
          },
        ),
      ]),
    );
  }
}
