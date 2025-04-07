import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
}
