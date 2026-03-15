import 'package:flutter/cupertino.dart';
import 'package:personal_finance_budgeting_system/data/repository/authRepository.dart';

import '../../../domain/models/user.dart';

class AuthViewModel extends ChangeNotifier{
  final AuthRepository _authRepo;
  User? _currentUser;
  bool _isLoading = false;
  String? _errMessage;

  AuthViewModel(this._authRepo);

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errMessage => _errMessage;

  Future<void> login(String email,String password) async{
    _isLoading = true;
    _errMessage = null;
    notifyListeners();

    try{
      _currentUser = await _authRepo.loginWithEmail(email, password);
    }catch(e){
      _errMessage = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}