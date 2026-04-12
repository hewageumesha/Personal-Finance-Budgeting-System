import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signUp(String email,String password);
  Future<UserEntity?> signIn(String email,String password);
  Future<void> loginOut();

  // Stream - a sequence of values over time (multiple of values over time)
  // not a one-time value — it changes over time.
  // A Stream emits meaning -> the stream produce/send a new value to whoever listening
  // we use authStateChanges method

  // creates a UserModel from another object (Firebase user).
  // this return a transformed version of usermodel , basically firebase user to this app's user model
  Stream<UserEntity?> get onAuthStateChanged;
}