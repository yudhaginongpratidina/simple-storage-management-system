import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/providers/category_provider.dart';
import 'package:storage_management_system/providers/product_provider.dart';

class FormAddProduct extends StatefulWidget {
  const FormAddProduct({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormAddProductState();
}

class _FormAddProductState extends State<FormAddProduct> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = context.watch<ProductProvider>();
    var categoryProvider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.inventory),
        title: const Text('Add Product'),
      ),
      body: Form(
        key: productProvider.formProduct,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: productProvider.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: productProvider.qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'QTY',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product qty';
                    }
                    // Check if the input contains only numbers
                    if (double.tryParse(value) == null) {
                      return 'Please enter numbers only';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items: categoryProvider.listCategory!.map((category) {
                    return DropdownMenuItem<int>(
                      value: category.id,
                      child: Text("${category.name}"),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        productProvider.categoryIdController.text =
                            value.toString();
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: productProvider.urlProductImageController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product image URL http://.. or https://..';
                    }
                    if (!value.startsWith('http://') &&
                        !value.startsWith('https://')) {
                      return 'URL must start with http:// or https://';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (productProvider.formProduct.currentState!.validate()) {
                      productProvider.createProduct(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text('Add Product'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text('Back'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
