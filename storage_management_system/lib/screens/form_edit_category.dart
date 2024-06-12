import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/providers/category_provider.dart';

class FormEditCategory extends StatefulWidget {
  final id;
  const FormEditCategory({super.key, this.id});

  @override
  State<FormEditCategory> createState() => _FormEditCategoryState();
}

class _FormEditCategoryState extends State<FormEditCategory> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().detailCategory(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = context.watch<CategoryProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.category),
        title: const Text('Edit Category'),
      ),
      body: Form(
        key: categoryProvider.formCategory,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: ListView(
              children: [
                TextFormField(
                  controller: categoryProvider.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (categoryProvider.formCategory.currentState!
                        .validate()) {
                      categoryProvider.updateCategory(context, widget.id);
                    } else {}
                  },
                  child: const Text('Edit Category'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.redAccent[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
