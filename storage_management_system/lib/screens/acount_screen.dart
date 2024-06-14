import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';
import 'package:storage_management_system/providers/auth_provider.dart';
import 'package:storage_management_system/screens/auth_screen.dart';
import 'package:storage_management_system/screens/form_edit_image.dart';
import 'package:storage_management_system/screens/form_edit_password.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({super.key});

  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  late SharedPreferences _sharedPref;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    context.read<AuthProvider>().detailUser(context);
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
                    imageURL: _sharedPref.getString('image') ?? '',
                    backToHome: true,
                    username: _sharedPref.getString('username') ?? '',
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.56,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: const BeveledRectangleBorder(),
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              var id = _sharedPref.getInt('id');
                              if (id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormEditImage(id: id),
                                  ),
                                );
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.camera),
                                SizedBox(width: 10),
                                Text('Change Image'),
                              ],
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: const BeveledRectangleBorder(),
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              var id = _sharedPref.getInt('id');
                              // print(id);
                              if (id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FormEditPassword(id: id),
                                  ),
                                );
                              } else {}
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.key),
                                SizedBox(width: 10),
                                Text('Change Password'),
                              ],
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              shape: const BeveledRectangleBorder(),
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              _sharedPref.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AuthScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout),
                                SizedBox(width: 10),
                                Text('Logout'),
                              ],
                            )),
                      ],
                    ),
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
