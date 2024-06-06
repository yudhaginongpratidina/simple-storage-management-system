import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/screens/auth_screen.dart';
import 'package:storage_management_system/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadingData();
  }

  // ===========================================================================
  // LOADING DATA
  // ---------------------------------------------------------------------------
  // KETIKA FUNCTION INI DIJALANKAN AKAN MELAKUKAN PENGECEKAN APAKAH TERDAPAT
  // DATA PREFERENCE ATAU TIDAK, JIKA ADA MAKA AKAN DIARAHKAN KE HALAMAN MAIN
  // JIKA TIDAK ADA MAKA AKAN DIARAHKAN KE HALAMAN LOGIN / AUTH
  // ============================================================================
  Future<void> loadingData() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var username = sharedPref.getString('username');
    Future.delayed(const Duration(seconds: 3), () {
      if (username == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(username: username),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: sizeScreen.width,
            height: sizeScreen.height,
            color: Colors.orange,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.storage, size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    'Storage Management System',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )));
  }
}
