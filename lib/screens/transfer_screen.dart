import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/transaction_provider.dart';
import 'package:mobile_app/providers/auth_provider.dart';

class TransferScreen extends StatelessWidget {
  final TextEditingController _targetAccountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedBank;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedBank,
              hint: Text('Select Bank'),
              items: <String>['Bank Celengan', 'Bank A', 'Bank B'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                _selectedBank = newValue;
              },
            ),
            TextField(
              controller: _targetAccountController,
              decoration: InputDecoration(labelText: 'Target Account'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (double.tryParse(_amountController.text) < 10000) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Minimum transfer amount is 10,000')),
                  );
                  return;
                }

                // Implement transfer logic with the API
              },
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
