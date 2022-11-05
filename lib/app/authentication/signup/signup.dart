import 'package:flutter/material.dart';
import 'name.dart';
import 'password.dart';
import 'email.dart';
import 'button.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const[
        Name(),
        SizedBox(
          height: 16.0,
        ),
        Email(),
        SizedBox(
          height: 16.0,
        ),
        Password(),
        SizedBox(
          height: 16.0,
        ),
        SignUpButton(),
      ],
    );
  }
}
