import 'package:flutter/material.dart';
import 'package:mobile_app/services/api_service.dart';
import 'login_screen.dart';
import 'mutasi_screen.dart';
import 'transfer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = '';
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final data = await ApiService.getCurrentUser();
      setState(() {
        _username = data['username'];
        _balance = data['balance'];
      });
    } catch (e) {
      // Handle error
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome, $_username!'),
            Text('Your current balance is \$$_balance'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MutasiScreen()),
                );
              },
              child: Text('View Transactions'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferScreen()),
                );
              },
              child: Text('Transfer Money'),
            ),
          ],
        ),
      ),
    );
  }
}
