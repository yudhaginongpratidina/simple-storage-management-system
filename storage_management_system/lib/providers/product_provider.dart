import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  // key
  final formProduct = GlobalKey<FormState>();

  // preference
  late SharedPreferences _sharedPref;

  // state
  ProductState productState = ProductState.initial;

  // url
  String url = 'http://192.168.1.6:3000';

  var name = '';
  var qty = '';
  var categoryId = '';
  var urlProductImage = '';
  List<Data>? listProduct = [];

  // controller
  TextEditingController nameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController urlProductImageController = TextEditingController();

  // fungsi get product by id user
  Future getProductByUserId(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();
    var userId = _sharedPref.getInt('id');

    try {
      var response = await Dio().get('$url/products/$userId');
      var result = ProductModel.fromJson(response.data);

      if (result.data!.isEmpty) {
        productState = ProductState.nodata;
      } else {
        productState = ProductState.success;
        listProduct = result.data;
      }

      // for (var data in listProduct!) {
      //   print('Data Id Product: ${data.id}');
      //   print('Data Name Product: ${data.name}');
      //   print('Data QTY Product: ${data.qty}');
      //   print('Data Category Id Product: ${data.categoryId}');
      //   print('Data Url Product Image: ${data.urlProductImage}');
      //   print('Nama Category : ${data.category!.name}');
      //   print('--------------------------------------------------------------');
      // }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
    notifyListeners();
  }

  // fungsi create new product
  Future createProduct(BuildContext context) async {
    try {
      _sharedPref = await SharedPreferences.getInstance();
      var userId = _sharedPref.getInt('id');

      var requestModel = {
        'name': nameController.text,
        'qty': qtyController.text,
        'categoryId': categoryIdController.text,
        'url_product_image': urlProductImageController.text,
        'user_id': userId
      };

      var response =
          await Dio().post('$url/products/$userId', data: requestModel);

      if (response.statusCode == 201 &&
          response.data['message'] == 'Product added successfully') {
        alertSuccess(context, response.data['message']);
        nameController.clear();
        qtyController.clear();
        categoryIdController.clear();
        urlProductImageController.clear();
      } else {
        alertFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
    notifyListeners();
  }

  // get detail product by id product
  Future detailProduct(BuildContext context, id) async {
    try {
      var response = await Dio().get('$url/products/detail/$id');
      print(response.data);
      nameController.text = response.data['data']['name'];
      qtyController.text = response.data['data']['qty'].toString();
      urlProductImageController.text =
          response.data['data']['url_product_image'];
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
    notifyListeners();
  }

  // fungsi update product
  Future updateProduct(BuildContext context, id) async {
    try {
      _sharedPref = await SharedPreferences.getInstance();
      var userId = _sharedPref.getInt('id');

      var requestModel = {
        'name': nameController.text,
        'qty': qtyController.text,
        'categoryId': categoryIdController.text,
        'url_product_image': urlProductImageController.text,
        'user_id': userId
      };

      var response =
          await Dio().patch('$url/products/$userId/$id', data: requestModel);
      if (response.statusCode == 200 &&
          response.data['message'] == 'Product updated successfully') {
        alertSuccess(context, response.data['message']);
        getProductByUserId(context);
      } else {
        alertFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
    notifyListeners();
  }

  // fungsi delete product by id
  Future deleteProduct(BuildContext context, id) async {
    try {
      var response = await Dio().delete('$url/products/$id');
      if (response.statusCode == 200 &&
          response.data['message'] == 'Success delete product') {
        Navigator.pop(context);
        getProductByUserId(context);
      } else {
        alertFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
    notifyListeners();
  }
}

// alert message success
void alertSuccess(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.green, size: 50),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      });
}

// alert message failed
void alertFailed(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: Colors.red, size: 50),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => {Navigator.pop(context)},
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

enum ProductState { initial, loading, success, error, nodata }
