import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    final response = await http.get(Uri.parse('$baseUrl/current-user'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load user data');
    }

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> getMutasi(DateTime from, DateTime to) async {
    final response = await http.get(
      Uri.parse('$baseUrl/mutasi?from=${from.toIso8601String()}&to=${to.toIso8601String()}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load transactions');
    }

    return jsonDecode(response.body);
  }

  static Future<void> transfer({
    required String bank,
    required String accountNumber,
    required double amount,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transfer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bank': bank,
        'accountNumber': accountNumber,
        'amount': amount,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to transfer');
    }
  }
}
