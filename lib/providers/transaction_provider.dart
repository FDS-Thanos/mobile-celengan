import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  Future<void> fetchTransactions(String token) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/mutasi'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      _transactions = responseData.map((data) => Transaction.fromJson(data)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }
}

class Transaction {
  final String date;
  final double amount;
  final String type;

  Transaction({this.date, this.amount, this.type});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['transaction_date'],
      amount: json['amount'],
      type: json['transaction_type'],
    );
  }
}
