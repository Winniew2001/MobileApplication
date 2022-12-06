import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/authentication_repository/authentication_exceptions.dart';
import 'package:mobile_application/app/authentication/authentication_repository/firebase_auth_repository/authentication_repository.dart';

final googleSignInProvider =
    StateNotifierProvider<GoogleSignInController, GoogleSignInState>((ref) {
  final authenticationRepository = ref.watch(fireBaseAuthRepoProvider);
  return GoogleSignInController(authenticationRepository);
});

enum GoogleSignInState { initial, loading, success, error }

/*
 * In charge of signing in via Google.
 */
class GoogleSignInController extends StateNotifier<GoogleSignInState> {
  final AuthenticationRepository _authenticationRepository;

  GoogleSignInController(this._authenticationRepository)
      : super(GoogleSignInState.initial);

  Future<void> signInWithGoogle() async {
    state = GoogleSignInState.loading;

    try {
      final isNewUser = await _authenticationRepository.signInWithGoogle();
      state = GoogleSignInState.success;
    } on SignInWithGoogleException catch (_) {
      state = GoogleSignInState.error;
    }
  }
}
