import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  User? get currentUser => _instance.currentUser;
  Stream<User?> get authStateChange => _instance.authStateChanges();

  Future<void> registerUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) return;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await _instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _instance.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _instance.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({required String newUsername}) async {
    await currentUser!.updateDisplayName(newUsername);
  }

  Future<void> deleteUser({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await _instance.signOut();
  }

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}
