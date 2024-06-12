import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({Key? key}) : super(key: key);

  @override
  _AcountScreenState createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  late SharedPreferences _sharedPref;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.person),
        title: const Text('Account'),
      ),
      body: FutureBuilder(
        future: _initSharedPreferences(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              color: Colors.indigo,
              child: Column(
                children: [
                  HeaderDetailMenu(
                    menuTitle: 'Account',
                    icon: const Icon(Icons.person),
                    backToHome: true,
                    username: _sharedPref.getString('username') ?? '',
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.56,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
