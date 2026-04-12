import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.uid, required super.email, required super.username});

  // factory for converting firebase usr to local-app usr
  factory UserModel.fromFirebase(dynamic firebaseusr) {
    return UserModel(
        uid: firebaseusr.id,
        email: firebaseusr.email,
        username: firebaseusr.username);
  }
}
