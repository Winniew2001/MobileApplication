part of 'signup_controller.dart';

class SignUpState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  const SignUpState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure,
      this.errorMessage});

  SignUpState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? errorMessage}) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [email, password, status];
}
