import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:mobile_application/app/authentication/behavior/email.dart';
import 'package:mobile_application/app/authentication/behavior/password.dart';

part 'signup_state.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
        (ref) => SignUpController());

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController() : super(const SignUpState());

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
    // TODO - implement this
    print("SIGNED UP");
  }
}
