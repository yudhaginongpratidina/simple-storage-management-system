import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/screens/auth_screen.dart';

class MainScreen extends StatefulWidget {
  final String? email;
  const MainScreen({super.key, this.email});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // print(prefs.getString('email'));
            prefs.remove('email');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
            );
          },
          child: Text(widget.email ?? 'No Email'),
        ),
      ),
    );
  }
}
