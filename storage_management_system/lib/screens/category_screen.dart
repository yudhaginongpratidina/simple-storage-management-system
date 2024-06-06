import 'package:flutter/material.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          leading: const Icon(Icons.category),
          title: const Text('Category'),
        ),
        body: Container(
          color: Colors.indigo,
          child: Column(
            children: [
              HeaderDetailMenu(
                menuTitle: 'Category',
                icon: const Icon(Icons.category),
                backToHome: true,
                onPressed: () {},
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                height: height * 0.56,
                width: width,
              )
            ],
          ),
        ));
  }
}
