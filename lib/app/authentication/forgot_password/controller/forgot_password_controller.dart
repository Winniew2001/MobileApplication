import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/authentication_repository/authentication_exceptions.dart';
import 'package:mobile_application/app/authentication/behavior/email.dart';
import '../../authentication_repository/firebase_auth_repository/authentication_repository.dart';
part 'forgot_password_state.dart';

final forgotPasswordProvider =
    StateNotifierProvider.autoDispose<ForgotPasswordController, ForgotPasswordState>(
        (ref) => ForgotPasswordController(ref.watch(fireBaseAuthRepoProvider)));

/*
 * In charge of helping users get new password.
 */
class ForgotPasswordController extends StateNotifier<ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;

  ForgotPasswordController(this._authenticationRepository)
      : super(const ForgotPasswordState());

  void onEmailChange(String value) {
    final email = Email.dirty(value);

    state = state.copyWith(email: email, status: Formz.validate([email]));
  }

  Future<void> forgotPassword() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.forgotPassword(email: state.email.value);
      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on ForgotPasswordException catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.code);
    }
  }
}
