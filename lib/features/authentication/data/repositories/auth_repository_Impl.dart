import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/model/category_model.dart';
import 'package:personal_finance_budgeting_system/features/finance/data/sources/local/finance_local_data.dart';
import 'package:personal_finance_budgeting_system/features/finance/domain/entities/category_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../sources/local/auth_local_data.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthLocalDataSource _localSource = AuthLocalDataSource();
  final FinanceLocalData _financeLocalData;

  AuthRepositoryImpl({required FinanceLocalData financeLocalData})
      : _financeLocalData = financeLocalData;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final String uid = credential.user!.uid;
      final user = await _localSource.getUserById(uid);

      return user;
    } on FirebaseAuthException catch (e) {
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

      // Save user to local SQLite
      await _localSource.saveUser(newUsr);

      // 🟢 Insert Default Categories for the new user
      await _insertDefaultCategories(newUsr.uid);

      return newUsr;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> _insertDefaultCategories(String uid) async {
    final List<Map<String, dynamic>> defaultCategories = [
      // Income
      {'name': 'salary', 'type': CategoryType.income},
      {'name': 'bonus', 'type': CategoryType.income},
      {'name': 'investment', 'type': CategoryType.income},
      {'name': 'savings', 'type': CategoryType.income},
      
      // Expense
      {'name': 'food', 'type': CategoryType.expense},
      {'name': 'groceries', 'type': CategoryType.expense},
      {'name': 'transport', 'type': CategoryType.expense},
      {'name': 'shopping', 'type': CategoryType.expense},
      {'name': 'health', 'type': CategoryType.expense},
      {'name': 'education', 'type': CategoryType.expense},
      {'name': 'entertainment', 'type': CategoryType.expense},
      {'name': 'rent', 'type': CategoryType.expense},
      {'name': 'utilities', 'type': CategoryType.expense},
      {'name': 'insurance', 'type': CategoryType.expense},
      {'name': 'gift', 'type': CategoryType.expense},
      {'name': 'charity', 'type': CategoryType.expense},
    ];

    for (var cat in defaultCategories) {
      final category = CategoryModel(
        cid: 'cat_${DateTime.now().microsecondsSinceEpoch}_${cat['name']}',
        cname: cat['name'],
        cType: cat['type'],
        userUid: uid,
      );
      await _financeLocalData.addLocalCategory(category);
    }
  }

  @override
  Future<void> loginOut() async {
    await _firebaseAuth.signOut();
  }

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
