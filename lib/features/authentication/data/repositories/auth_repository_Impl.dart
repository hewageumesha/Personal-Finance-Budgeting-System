import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_finance_budgeting_system/features/authentication/data/soruces/local/auth_local_data.dart';
import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthLocalDataSource _localSource = AuthLocalDataSource();

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final String uid = credential.user!.uid;
      final user = await _localSource.getUserById(uid);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  @override
  Future<UserModel?> signUp(
      String username, String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final newUsr = UserModel.fromFirebase(credential.user, username);

      // add sqlite save user method here (sqlite)
      await _localSource.saveUser(newUsr);

      return newUsr;
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
  Stream<UserEntity?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().asyncMap((usr) async {
        if (usr == null) return null;
        final localUser = await _localSource.getUserById(usr.uid);
        if (localUser != null) {
          return localUser;
        }
        return null;
      });
}
