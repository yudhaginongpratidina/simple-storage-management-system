import 'package:flutter/material.dart';
import 'package:storage_management_system/components/header_home.dart';
import 'package:storage_management_system/components/menu_home.dart';

class MainScreen extends StatefulWidget {
  final String? username;
  const MainScreen({super.key, this.username});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: [
            HeaderHome(username: widget.username),
            const MenuHome(),
          ],
        ),
      ),
    );
  }
}
