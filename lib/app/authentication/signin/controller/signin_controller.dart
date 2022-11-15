import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../authentication_repository/authentication_exceptions.dart';
import '../../authentication_repository/firebase_auth_repository/authentication_repository.dart';
import '../../behavior/email.dart';
import '../../behavior/password.dart';

part 'signin_state.dart';

final signInProvider =
    StateNotifierProvider.autoDispose<SignInController, SignInState>(
        (ref) => SignInController(ref.watch(fireBaseAuthRepoProvider)));

class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository _authenticationRepository;

  SignInController(this._authenticationRepository) : super(const SignInState());

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

  void signInWithEmail() async {
    if (!state.status.isValidated) return;
    state = state.copyWith(status: FormzStatus.submissionInProgress);
    try {
      await _authenticationRepository.signInWithEmail(
          email: state.email.value, password: state.password.value);

      state = state.copyWith(status: FormzStatus.submissionSuccess);
    } on SignInWithEmailException catch (e) {
      state = state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.code);
    }
  }
}
