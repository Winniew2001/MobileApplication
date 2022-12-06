import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/behavior/email.dart';
import 'package:mobile_application/app/authentication/signup/controller/signup_controller.dart';
import '../../components/text_input_field.dart';

/*
 * Field for entering email.
 */
class EmailField extends ConsumerWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final showError = signUpState.email.invalid;
    final signUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      hintText: "Email",
      errorText: showError
          ? Email.showEmailErrorMessage(signUpState.email.error)
          : null,
      onChanged: (email) => signUpController.onEmailChanged(email),
    );
  }
}
