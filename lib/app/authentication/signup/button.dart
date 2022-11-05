import 'package:flutter/material.dart';
import '../../components/animated_button.dart';
import '../../components/rounded_button_style.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onTap: () {},
      child: const RoundedButtonStyle(
        title: "Sign up",
      ),
    );
  }
}
