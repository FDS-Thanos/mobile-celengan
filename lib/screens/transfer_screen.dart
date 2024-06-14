import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/user_provider.dart';
import 'package:mobile_app/services/api_service.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String _selectedBank = 'Bank Celengan';
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  String _errorMessage = '';

  void _transfer() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount < 10000) {
      setState(() {
        _errorMessage = 'Minimum transfer amount is 10,000';
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.balance < amount) {
      setState(() {
        _errorMessage = 'Insufficient balance';
      });
      return;
    }

    try {
      await ApiService.transfer(
        bank: _selectedBank,
        accountNumber: _accountController.text,
        amount: amount,
      );
      setState(() {
        _errorMessage = '';
      });
      // Update balance after transfer
      await userProvider.fetchCurrentUser();
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Transfer failed, please try again';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Money'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedBank,
              items: <String>['Bank Celengan', 'Bank Lain']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedBank = newValue!;
                });
              },
            ),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(labelText: 'Account Number'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transfer,
              child: Text('Transfer'),
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
