import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:storage_management_system/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  // KEY
  final formCategory = GlobalKey<FormState>();

  // STATE
  CategoryState categoryState = CategoryState.initial;

  var name = '';
  String url = 'http://192.168.1.6:3000';

  // CONTROLLER
  TextEditingController nameController = TextEditingController();

  List<Data>? listCategory = [];
  var state = CategoryState.initial;

  // FUNGSI GET CATEGORY
  Future getCategory(BuildContext context) async {
    try {
      var response = await Dio().get('$url/categories');
      var result = CategoryModel.fromJson(response.data);

      if (result.data!.isEmpty) {
        categoryState = CategoryState.nodata;
      } else {
        categoryState = CategoryState.success;
        listCategory = result.data;
      }

      // for (var data in listCategory!) {
      //   print(
      //       'Data id: ${data.id}, name: ${data.name}, createdAt: ${data.createdAt}, updatedAt: ${data.updatedAt}');
      //   print('Data length: ${listCategory!.length}');
      // }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }

    notifyListeners();
  }

  // FUNGSI CREATE CATEGORY
  Future createCategory(BuildContext context) async {
    try {
      var requestModel = {
        'name': nameController.text,
      };
      var response = await Dio().post('$url/categories', data: requestModel);

      if (response.statusCode == 201 &&
          response.data['message'] == 'Category created successfully') {
        alertSuccess(context, response.data['message']);
        nameController.clear();
        getCategory(context);
      } else {
        nameController.clear();
        alertFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      alertFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  // FUNGSI DETAIL CATEGORY BY ID
  Future detailCategory(BuildContext context, int id) async {
    try {
      var response = await Dio().get('$url/categories/$id');
      nameController.text = response.data['data']['name'];
    } on DioException catch (e) {
      alertFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  // FUNGSI UPDATE CATEGORY BY ID
  Future updateCategory(BuildContext context, int id) async {
    try {
      var requestModel = {
        'name': nameController.text,
      };
      var response =
          await Dio().patch('$url/categories/$id', data: requestModel);
      if (response.statusCode == 200 &&
          response.data['message'] == 'Category updated successfully') {
        alertSuccess(context, response.data['message']);
        nameController.clear();
        getCategory(context);
      } else {
        nameController.clear();
        alertFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      alertFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  // FUTURE DELETE CATEGORY BY ID
  Future deleteCategory(BuildContext context, int id) async {
    try {
      var response = await Dio().delete('$url/categories/$id');

      if (response.statusCode == 200 && response.data['message'] == 'Success') {
        alertSuccess(context, response.data['message']);
      } else {
        alertFailed(context, response.data['message']);
      }
      getCategory(context);
    } on DioException catch (e) {
      alertFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  // ==========================================================================================
//  FUNCTION ALERT FIELD EMPTY
// ==========================================================================================
  void showAlertFieldEmpty(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 50),
              SizedBox(height: 8),
              Text(
                'Please fill in the fields',
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
      },
    );
  }
}

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

// ==========================================================================================
// FUNGSI UNTUK ALERT FAILED
// ==========================================================================================
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

enum CategoryState { initial, loading, success, error, nodata }
