import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/providers/auth_provider.dart';
import 'package:storage_management_system/providers/category_provider.dart';
import 'package:storage_management_system/screens/splash_screen.dart';

void main() {
  runApp(const StorageManagementSystem());
}

class StorageManagementSystem extends StatelessWidget {
  const StorageManagementSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ================================================================
      // PROVIDERS
      // ================================================================
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        )
      ],

      // ================================================================
      // WIDGETS
      // ================================================================
      child: MaterialApp(
        title: 'Storage Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // ================================================================
        // REMOVE BANNDER DEBUG
        // ================================================================
        debugShowCheckedModeBanner: false,

        // ================================================================
        // HOME
        // ================================================================
        // home: const AuthScreen(),
        home: SplashScreen(),
      ),
    );
  }
}
