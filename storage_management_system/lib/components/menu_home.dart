import 'package:flutter/material.dart';
import 'package:storage_management_system/components/alert_logout.dart';
import 'package:storage_management_system/screens/about_screen.dart'; // Perbaikan nama file
import 'package:storage_management_system/screens/acount_screen.dart';
import 'package:storage_management_system/screens/category_screen.dart';
import 'package:storage_management_system/screens/product_screen.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key); // Menggunakan Key? key

  @override
  State<StatefulWidget> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  List menuName = [
    'Category',
    'Products',
    'Account',
    'About',
    'Log Out',
  ];

  List menuIcon = [
    Icons.category,
    Icons.inventory,
    Icons.person,
    Icons.info,
    Icons.exit_to_app,
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      height: height * 0.77,
      width: width,
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.1,
              mainAxisSpacing: 20,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuName.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  // Tambahkan async
                  try {
                    // Tambahkan try-catch
                    if (menuName[index] == 'Category') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryScreen(),
                        ),
                      );
                    }
                    if (menuName[index] == 'Products') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductScreen(),
                        ),
                      );
                    }
                    if (menuName[index] == 'Account') {
                      // Tambahkan await
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AcountScreen(),
                        ),
                      );
                    }
                    if (menuName[index] == 'About') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    }
                    if (menuName[index] == 'Log Out') {
                      AlertLogout.show(context);
                    }
                  } catch (e) {
                    // Tangani pengecualian
                    print('Error: $e');
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        menuIcon[index],
                        size: 24,
                        color: Colors.indigo,
                      ),
                      Text(
                        menuName[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
