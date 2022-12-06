import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

/*
 * Password validation.
 */
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  // TODO - Password must contain at least one digit
  //  as well as at least one small and one capitalized letter
  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 6) {
      return PasswordValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showPasswordErrorMessage(PasswordValidationError? error) {
    if (error == PasswordValidationError.empty) {
      return 'Empty password field';
    } else if (error == PasswordValidationError.invalid) {
      return 'Password is too short';
    } else {
      return null;
    }
  }
}
