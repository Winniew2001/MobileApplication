import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/signup/controller/signup_controller.dart';
import 'package:mobile_application/app/components/loading_error.dart';
import '../../../misc/loading_sheet.dart';
import 'password_field.dart';
import 'email_field.dart';
import 'signup_button.dart';

/*
 * Widget for creating a user.
 */
class SignUp extends ConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpProvider, (previous, current) {
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
        SizedBox(
          height: 16.0,
        ),
        SignUpButton(),
      ],
    );
  }
}
