import 'package:flutter/material.dart';
import 'password_field.dart';
import 'email_field.dart';
import 'signup_button.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EmailField(),
        SizedBox(
          height: 16.0,
        ),
        PasswordField(),
        SizedBox(
          height: 16.0,
        ),
        SignUpButton(),
      ],
    );
  }
}
