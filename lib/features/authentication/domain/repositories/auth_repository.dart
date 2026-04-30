import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signUp(String username,String email,String password);
  Future<UserEntity?> signIn(String email,String password);
  Future<void> loginOut();

  Stream<UserEntity?> get onAuthStateChanged;
}