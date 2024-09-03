import 'package:flutter/material.dart';
import 'package:to_do_list/data/api/api_service.dart';
import 'package:to_do_list/data/model/login_response.dart';
import 'package:to_do_list/data/model/register_response.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService apiService;

  AuthProvider(this.apiService);

  bool _isLoadingLogin = false;
  String? _errorMessageLogin;
  LoginResponse? _loginResponse;

  bool _isLoadingRegister = false;
  String? _errorMessageRegister;
  RegisterResponse? _registerResponse;

  bool get isLoadingLogin => _isLoadingLogin;
  String? get errorMessageLogin => _errorMessageLogin;
  LoginResponse? get loginResponse => _loginResponse;

  bool get isLoadingRegister => _isLoadingRegister;
  String? get errorMessageRegister => _errorMessageRegister;
  RegisterResponse? get registerResponse => _registerResponse;

  Future<void> login(String username, String password) async {
    _isLoadingLogin = true;
    _errorMessageLogin = null;
    notifyListeners();

    final result = await apiService.login(username, password);
    _loginResponse = result;

    if (_loginResponse?.data?.token != null) {
      _isLoadingLogin = false;
      _errorMessageLogin = null;
      notifyListeners();
    } else {
      _isLoadingLogin = false;
      _errorMessageLogin = _loginResponse?.message ?? "Login gagal";
      notifyListeners();
    }
  }

  Future<void> register(String email, String username, String password) async {
    _isLoadingRegister = true;
    _errorMessageRegister = null;
    notifyListeners();

    final result = await apiService.register(email, username, password);
    _registerResponse = result;

    if (_registerResponse?.statusCode != 2000) {
      _isLoadingRegister = false;
      _errorMessageRegister = _registerResponse?.message ?? "Register gagal";
      notifyListeners();
    }
  }
}
