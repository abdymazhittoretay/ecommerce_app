import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  User? get currentUser => _instance.currentUser;
  Stream<User?> get authStateChange => _instance.authStateChanges();
}
