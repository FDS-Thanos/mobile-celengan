import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_service.dart';

class TransactionProvider with ChangeNotifier {
  List _transactions = [];
  String _errorMessage = '';

  List get transactions => _transactions;
  String get errorMessage => _errorMessage;

  Future<void> fetchTransactions(DateTime from, DateTime to) async {
    try {
      _transactions = await ApiService.getMutasi(from, to);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load transactions';
      notifyListeners();
    }
  }
}
