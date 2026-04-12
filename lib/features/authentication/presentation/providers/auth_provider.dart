import 'package:flutter/material.dart';
import 'package:personal_finance_budgeting_system/features/authentication/domain/entities/user_entity.dart';
import 'package:personal_finance_budgeting_system/features/authentication/domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  UserEntity? _user;
  bool _isLoading = false;

  AuthProvider(this._authRepository) {
    _authRepository.onAuthStateChanged.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  // getter
  UserEntity? get user => _user;

  bool get isLoading => _isLoading;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await _authRepository.signIn(email, password);
    } catch (e) {
      rethrow; // come again
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String username,String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await _authRepository.signUp(username,email, password);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
