import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/signup/controller/signup_controller.dart';

import '../../components/animated_button.dart';
import '../../components/rounded_button_style.dart';

class SignUpButton extends ConsumerWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpController = ref.read(signUpProvider.notifier);
    final isValidated = signUpState.status.isValidated;
    return AnimatedButton(
      onTap: isValidated
          ? () => signUpController.signUpWithEmail()
          : null,
      child: const RoundedButtonStyle(
        title: "Sign up",
      ),
    );
  }
}

// TODO - what this?
//ErrorDialog.show(context, "Failed SignUp");
//LoadingSheet.show(context)