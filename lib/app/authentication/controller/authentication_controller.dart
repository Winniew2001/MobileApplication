import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_application/app/authentication/authentication_repository/auth_user.dart';
import 'package:mobile_application/app/authentication/authentication_repository/firebase_auth_repository/authentication_repository.dart';

part 'authentication_state.dart';

final authProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>(
        (ref) => AuthenticationController(ref.watch(fireBaseAuthRepoProvider)));

class AuthenticationController extends StateNotifier<AuthenticationState> {
  final AuthenticationRepository _authRepository;
  late final StreamSubscription _streamSubscription;

  AuthenticationController(this._authRepository)
      : super(const AuthenticationState.unauthenticated()) {
    _authRepository.user.listen((user) {
      _onUserChanged(user);
    });
  }

  void _onUserChanged(AuthUser user) {
    if (user.isEmpty) {
      state = const AuthenticationState.unauthenticated();
    } else {
      state = AuthenticationState.authenticated(user);
    }
  }

  void onSignOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
