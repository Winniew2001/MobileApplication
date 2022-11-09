import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth_user.dart';
import '../authentication_exceptions.dart';

final fireBaseAuthRepoProvider = Provider<AuthenticationRepository>(
    (_) => AuthenticationRepository()
);

class AuthenticationRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.standard();

  Stream<AuthUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthUser.empty
          : AuthUser(
              id: firebaseUser.uid,
              email: firebaseUser.email,
              emailVerified: firebaseUser.emailVerified);
    });
  }

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailException(e.code);
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailException(e.code);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ForgotPasswordException(e.code);
    }
  }

  Future<bool?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw SignInWithGoogleException();
      }

      final googleSignInAuth = await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken);

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.additionalUserInfo?.isNewUser;
    } on FirebaseAuthException catch (_) {
      throw SignInWithGoogleException();
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (_) {
      throw SignOutException();
    }
  }
}
