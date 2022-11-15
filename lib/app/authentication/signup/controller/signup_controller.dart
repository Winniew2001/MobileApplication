import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/authentication_repository/authentication_exceptions.dart';
import 'package:mobile_application/app/authentication/behavior/email.dart';
import 'package:mobile_application/app/authentication/behavior/password.dart';

import '../../authentication_repository/firebase_auth_repository/authentication_repository.dart';

part 'signup_state.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        (ref) => SignUpController(ref.watch(fireBaseAuthRepoProvider)));

class SignUpController extends StateNotifier<SignUpState> {
  final AuthenticationRepository _authenticationRepository;

  SignUpController(this._authenticationRepository) : super(const SignUpState());

  void onEmailChanged(String value) {
    final email = Email.dirty(value);

    state = state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
        ]));
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);

    state = state.copyWith(
        password: password,
        status: Formz.validate([
          state.email,
          password,
        ]));
  }

  void signUpWithEmail() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.signUpWithEmail(
          email: state.email.value, password: state.password.value);

      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SignUpWithEmailException catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.code);
    }
  }
}
