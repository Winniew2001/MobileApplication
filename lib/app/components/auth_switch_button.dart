import 'package:flutter/material.dart';

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
          child: Text("Toggle"),
        ),
      ),
    );
  }
}
