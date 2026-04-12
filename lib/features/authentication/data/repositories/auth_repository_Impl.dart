import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';

import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  @override
  Future<UserModel?> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return UserModel.fromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> loginOut() async {
    await _firebaseAuth.signOut();
  }

  // this getter method always changes and trigger when usr sign in/up or out
  @override
  Stream<UserEntity?> get onAuthStateChanged => _firebaseAuth
      .authStateChanges()
      .map((usr) => usr != null ? UserModel.fromFirebase(usr) : null);
}
