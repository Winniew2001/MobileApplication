/*
 * Exceptions.
 */


class SignUpWithEmailException implements Exception {
  final String code;
  const SignUpWithEmailException(this.code);
}

class SignInWithEmailException implements Exception {
  final String code;
  const SignInWithEmailException(this.code);
}

class ForgotPasswordException implements Exception {
  final String code;
  const ForgotPasswordException(this.code);
}

class SignInWithGoogleException implements Exception {}

class SignOutException implements Exception {}