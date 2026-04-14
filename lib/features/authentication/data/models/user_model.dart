import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.uid,
      required super.email,
      required super.username,
      required super.createdAt});

  // dynamic -> hold any type of value, and Dart will decide things at runtime.”
  // factory for converting firebase usr to local-app usr
  factory UserModel.fromFirebase(dynamic user, String username) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      username: username,
      createdAt: DateTime.now(),
    );
  }

  // fetch from database
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        username: map['username'],
        createdAt: DateTime.parse(map['createdAt']));
  }

  // convert User to  Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // for debugging
  @override
  String toString() {
    return 'User(uid: $uid, username: $username, email: $email)';
  }
}
