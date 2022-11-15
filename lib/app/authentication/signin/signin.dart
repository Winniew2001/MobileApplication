import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/google_signin/google_sign_in_button.dart';
import 'package:mobile_application/app/authentication/signin/divider.dart';
import '../../components/loading_error.dart';
import 'controller/signin_controller.dart';
import 'password_field.dart';
import 'email_field.dart';
import 'signin_button.dart';
import 'forgot_password_button.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignInState>(signInProvider, (previous, current) {
      if (current.status.isSubmissionInProgress) {
        LoadingSheet.show(context);
      } else if (current.status.isSubmissionFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      } else if (current.status.isSubmissionSuccess) {
        Navigator.of(context).pop();
      }
    });

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
