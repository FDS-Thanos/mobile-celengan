import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  String _token;
  String _username;
  double _balance;

  String get token => _token;
  String get username => _username;
  double get balance => _balance;

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/api/login'),
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _token = responseData['token'];
      _username = responseData['user']['username'];
      _balance = responseData['user']['balance'];
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }
}
