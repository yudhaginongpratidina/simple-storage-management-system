import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/components/header_detail_menu.dart';
import 'package:storage_management_system/providers/category_provider.dart';
import 'package:storage_management_system/screens/form_add_category.dart';
import 'package:storage_management_system/screens/form_edit_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getCategory(context);
  }

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormAddCategory(),
                  ),
                );
              },
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                height: height * 0.56,
                width: width,
                child: ListView.builder(
                  itemCount:
                      context.watch<CategoryProvider>().listCategory!.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: index % 2 == 0
                            ? Colors.indigo.shade100
                            : Colors.indigo.shade200,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            context
                                .watch<CategoryProvider>()
                                .listCategory![index]
                                .name
                                .toString(),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: InkWell(
                                onTap: () {
                                  final categoryProvider =
                                      Provider.of<CategoryProvider>(context,
                                          listen: false);
                                  final categoryId =
                                      categoryProvider.listCategory![index].id;
                                  if (categoryId != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormEditCategory(id: categoryId),
                                      ),
                                    );
                                  }
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: InkWell(
                                onTap: () {
                                  final categoryProvider =
                                      Provider.of<CategoryProvider>(context,
                                          listen: false);
                                  final categoryId =
                                      categoryProvider.listCategory![index].id;
                                  if (categoryId != null) {
                                    categoryProvider.deleteCategory(
                                        context, categoryId);
                                  }
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
