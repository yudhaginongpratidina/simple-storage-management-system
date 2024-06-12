import 'package:flutter/material.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.inventory),
        title: const Text('Products'),
      ),
      body: Container(
        color: Colors.indigo,
        child: Column(
          children: [
            HeaderDetailMenu(
              menuTitle: 'Product',
              icon: const Icon(Icons.inventory),
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
      ),
    );
  }
}
