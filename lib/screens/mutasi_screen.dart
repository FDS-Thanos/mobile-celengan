import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/transaction_provider.dart';
import 'package:mobile_app/providers/auth_provider.dart';

class MutasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await transactionProvider.fetchTransactions(authProvider.token);
              },
              child: Text('Load Transactions'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactionProvider.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactionProvider.transactions[index];
                  return ListTile(
                    title: Text('${transaction.date} - ${transaction.amount} - ${transaction.type}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
