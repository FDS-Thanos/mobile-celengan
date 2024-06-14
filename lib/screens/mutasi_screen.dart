import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/providers/transaction_provider.dart';

class MutasiScreen extends StatefulWidget {
  @override
  _MutasiScreenState createState() => _MutasiScreenState();
}

class _MutasiScreenState extends State<MutasiScreen> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() async {
    await Provider.of<TransactionProvider>(context, listen: false).fetchTransactions(
      _selectedDateRange.start,
      _selectedDateRange.end,
    );
  }

  void _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        _fetchTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: _pickDateRange,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: transactionProvider.transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactionProvider.transactions[index];
          return ListTile(
            title: Text(transaction['description']),
            subtitle: Text(transaction['date']),
            trailing: Text(
              transaction['amount'] > 0
                  ? '+\$${transaction['amount']}'
                  : '-\$${transaction['amount'].abs()}',
              style: TextStyle(
                color: transaction['amount'] > 0 ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
