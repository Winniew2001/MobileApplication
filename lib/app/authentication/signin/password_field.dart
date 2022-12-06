import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/text_input_field.dart';
import '../behavior/password.dart';
import 'controller/signin_controller.dart';

/*
 * Field for entering password.
 */
class PasswordField extends ConsumerWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final showError = signInState.password.invalid;
    final signInController = ref.read(signInProvider.notifier);
    return TextInputField(
      hintText: "Password",
      obscureText: true,
      errorText: showError
          ? Password.showPasswordErrorMessage(signInState.password.error)
          : null,
      onChanged: (password) => signInController.onPasswordChanged(password),
    );
  }
}