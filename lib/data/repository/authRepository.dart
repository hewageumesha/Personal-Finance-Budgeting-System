import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:personal_finance_budgeting_system/domain/models/user.dart';

class AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  Stream<firebase.User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> loginWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final firebaseUser = credential.user;

      return User(
          id: firebaseUser?.uid,
          email: firebaseUser?.email,
          username: "root",
          baseCurrency: "LKR");
    } catch (e) {
      throw Exception("Login Failed ${e.toString()}");
    }
  }
}
