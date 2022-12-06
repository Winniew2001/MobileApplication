import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/forgot_password/controller/forgot_password_controller.dart';
import 'package:mobile_application/app/components/loading_error.dart';
import 'package:mobile_application/app/components/text_input_field.dart';
import '../behavior/email.dart';

/*
 * Page for displaying reset password.
 */
class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  String _getButtonText(FormzStatus status) {
    if (status.isSubmissionInProgress) {
      return 'Requesting';
    } else if (status.isSubmissionFailure) {
      return 'Failed';
    } else if (status.isSubmissionSuccess) {
      return 'Done';
    } else {
      return 'Request';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final status = forgotPasswordState.status;

    ref.listen<ForgotPasswordState>(forgotPasswordProvider,
        (previous, current) {
      if (current.status.isSubmissionFailure) {
        Navigator.of(context).pop();
        ErrorDialog.show(context, "${current.errorMessage}");
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInputField(
                hintText: "Please enter your Email",
                errorText: Email.showEmailErrorMessage(
                    forgotPasswordState.email.error),
                onChanged: (email) {
                  ref
                      .read(forgotPasswordProvider.notifier)
                      .onEmailChange(email);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: status.isSubmissionInProgress
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: status.isSubmissionInProgress ||
                            status.isSubmissionSuccess
                        ? null
                        : () {
                            ref
                                .read(forgotPasswordProvider.notifier)
                                .forgotPassword();
                          },
                    child: Text(_getButtonText(status)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
