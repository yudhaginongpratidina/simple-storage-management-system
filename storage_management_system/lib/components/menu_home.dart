import 'package:flutter/material.dart';
import 'package:storage_management_system/components/alert_logout.dart';
import 'package:storage_management_system/screens/about_screen.dart';
import 'package:storage_management_system/screens/category_screen.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({super.key});

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
    // -------------------------------------------
    // SCREEN SIZE
    // -------------------------------------------
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // -------------------------------------------
    // CONTAINER MENU
    // -------------------------------------------
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
          // --------------------------------------------------------------
          // GRID VIEW FOR MENU -START
          // --------------------------------------------------------------
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.1,
              mainAxisSpacing: 20,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            // --------------------------------------------------------------
            // ITEM COUNT
            // --------------------------------------------------------------
            itemCount: menuName.length,

            itemBuilder: (context, index) {
              return InkWell(
                // --------------------------------------------------------------
                // NAVIGATION
                // --------------------------------------------------------------
                onTap: () {
                  if (menuName[index] == 'Category') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryScreen(),
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
                },

                // --------------------------------------------------------------
                // STYLE MENU
                // --------------------------------------------------------------
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

                  // --------------------------------------------------------------
                  // LOOPING MENU
                  // --------------------------------------------------------------
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
          // --------------------------------------------------------------
          // GRID VIEW FOR MENU - END
          // --------------------------------------------------------------
        ],
      ),
    );
  }
}
