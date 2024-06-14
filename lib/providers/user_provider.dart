import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_service.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  double _balance = 0.0;
  bool _isAuthenticated = false;
  String _errorMessage = '';

  String get username => _username;
  double get balance => _balance;
  bool get isAuthenticated => _isAuthenticated;
  String get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    try {
      await ApiService.login(username, password);
      _isAuthenticated = true;
      await fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Login failed, please try again';
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      final data = await ApiService.getCurrentUser();
      _username = data['username'];
      _balance = data['balance'];
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load user data';
      notifyListeners();
    }
  }

  void logout() {
    _username = '';
    _balance = 0.0;
    _isAuthenticated = false;
    notifyListeners();
  }
}
