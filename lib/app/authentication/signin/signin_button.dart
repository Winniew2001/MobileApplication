import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import '../../../misc/animated_button.dart';
import '../../components/rounded_button_style.dart';
import 'controller/signin_controller.dart';

/*
 * Button for signing in.
 */
class SignInButton extends ConsumerWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInProvider);
    final signInController = ref.read(signInProvider.notifier);
    final isValidated = signInState.status.isValidated;
    return AnimatedButton(
      onTap: isValidated
          ? () => signInController.signInWithEmail()
          : null,
      child: const RoundedButtonStyle(
        title: "Sign In",
      ),
    );
  }
}
