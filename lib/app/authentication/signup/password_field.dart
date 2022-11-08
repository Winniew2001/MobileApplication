import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/signup/controller/signup_controller.dart';

import '../../components/text_input_field.dart';
import '../behavior/password.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final showError = signUpState.password.invalid;
    final signUpController = ref.read(signUpProvider.notifier);
    return TextInputField(
      hintText: "Password",
      obscureText: true,
      errorText: showError
          ? Password.showPasswordErrorMessage(signUpState.password.error)
          : null,
      onChanged: (password) => signUpController.onPasswordChanged(password),
    );
  }
}
