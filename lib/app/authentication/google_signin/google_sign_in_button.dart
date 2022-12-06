import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/google_signin/controller/google_sign_in_controller.dart';
import 'package:mobile_application/app/components/animated_button.dart';
import 'package:mobile_application/app/components/loading_error.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<GoogleSignInState>(googleSignInProvider, (previous, current) {
      if (current == GoogleSignInState.loading) {
        LoadingSheet.show(context);
      } else if (current == GoogleSignInState.error) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "Google sign in failed");
      } else {
        Navigator.of(context).pop();
      }
    });

    return AnimatedButton(
      onTap: () {
        ref.read(googleSignInProvider.notifier).signInWithGoogle();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: const Text(
          "Sign In With Google",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
