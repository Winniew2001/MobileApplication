import 'package:flutter/material.dart';
import 'package:mobile_application/app/components/slide_fade_switcher.dart';

const _kTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Color(0xFF9A9A9A),
);

class AuthSwitchButton extends StatelessWidget {
  final bool showSignIn;
  final VoidCallback onTap;

  const AuthSwitchButton(
      {Key? key, required this.showSignIn, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16.0),
          child: SlideFadeSwitcher(
            child: showSignIn
                ? const Text(
                    "Don't have an account? Sign Up",
                    key: ValueKey("SignIn"),
                    style: _kTextStyle,
                  )
                : const Text(
                    "Already have an account? Sign In",
                    key: ValueKey("SignUp"),
                    style: _kTextStyle,
                  ),
          ),
        ),
      ),
    );
  }
}
