import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';
import 'package:storage_management_system/providers/product_provider.dart';
import 'package:storage_management_system/screens/form_add_product.dart';
import 'package:storage_management_system/screens/form_edit_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductProvider>().getProductByUserId(context);
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormAddProduct(),
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.98,
                      mainAxisSpacing: 2,
                    ),
                    itemCount:
                        context.watch<ProductProvider>().listProduct!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormEditProduct(
                                      id: context
                                          .read<ProductProvider>()
                                          .listProduct![index]
                                          .id!)));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2.5),
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.indigo),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                context
                                    .watch<ProductProvider>()
                                    .listProduct![index]
                                    .urlProductImage!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.grey.shade200,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      context
                                          .watch<ProductProvider>()
                                          .listProduct![index]
                                          .name!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.indigo,
                                          ),
                                          child: Text(
                                            context
                                                .watch<ProductProvider>()
                                                .listProduct![index]
                                                .category!
                                                .name!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.indigo,
                                          ),
                                          child: Text(
                                            'stock : ${context.watch<ProductProvider>().listProduct![index].qty}',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
