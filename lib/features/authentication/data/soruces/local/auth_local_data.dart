import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';
import '../../../../../core/db/db_helper.dart';
import '../../models/user_model.dart';

class AuthLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> saveUser(UserEntity user) async {
    final db = await _databaseHelper.db;
    await db?.insert('users', {
      'uid': user.uid,
      'username': user.username,
      'email': user.email,
      'createdAt': user.createdAt
    });
  }

  Future<UserModel?> getUserById(String uid) async {
    final db = await _databaseHelper.db;
    List<Map<String, dynamic>>? usersList =
        await db?.query('user', where: 'uid = ?', whereArgs: [uid]);

    if (usersList!.isNotEmpty) {
      return UserModel.fromMap(usersList.first);
    }

    return null;
  }

  Future<void> deleteUser(String uid) async {}

  Future<void> updateUser() async {}
}
