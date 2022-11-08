import 'package:flutter/material.dart';
import 'package:mobile_application/app/authentication/google_signin/google_sign_in_button.dart';
import 'package:mobile_application/app/authentication/signin/or_divider.dart';
import 'password_field.dart';
import 'email_field.dart';
import 'signin_button.dart';
import 'forgot_password_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EmailField(),
        SizedBox(
          height: 16.0,
        ),
        PasswordField(),
        ForgotPasswordButton(),
        SizedBox(
          height: 16.0,
        ),
        SignInButton(),
        OrDivider(),
        GoogleSignInButton(),
      ],
    );
  }
}
