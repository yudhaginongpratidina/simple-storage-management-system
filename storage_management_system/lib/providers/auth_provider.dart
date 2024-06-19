import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/screens/main_screen.dart';

class AuthProvider extends ChangeNotifier {
  late SharedPreferences _sharedPref;

  final formAuthentication = GlobalKey<FormState>();
  StateAuth authState = StateAuth.initial;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formTitle = 'Sign In';
  var username = '';
  var password = '';
  var messageError = '';
  bool obscurePassword = true;
  String url = 'http://192.168.1.6:3000';

  // ==========================================================================================
  // FUNGSI UNTUK UPDATE TITLE
  // ==========================================================================================
  void updateFormTitle() {
    if (formTitle == 'Sign In') {
      formTitle = 'Sign Up';
      usernameController.clear();
      passwordController.clear();
    } else {
      formTitle = 'Sign In';
      passwordController.clear();
    }

    notifyListeners();
  }

  // ==========================================================================================
  // FUNGSI UNTUK HANDLE LOGIN
  // ==========================================================================================
  Future processLogin(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();

    try {
      var requestModel = {
        'username': usernameController.text,
        'password': passwordController.text
      };

      var response = await Dio().post('$url/login', data: requestModel);

      if (response.statusCode == 200 &&
          response.data['message'] == 'Login Success') {
        _sharedPref.setInt('id', response.data['data']['id']);
        _sharedPref.setString('username', response.data['data']['username']);
        _sharedPref.setString('password', response.data['data']['password']);

        var image = response.data['data']['image'];
        _sharedPref.setString('image', '$url/public/images/$image');
        alertAuthSuccess(context, response.data['message']);
      } else {
        alertAuthFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      alertAuthFailed(context, 'Error: ${e.message}');
    }

    notifyListeners();
  }

  // ==========================================================================================
  // FUNGSI UNTUK HANDLE REGISTER
  // ==========================================================================================
  Future processRegister(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();

    try {
      var requestModel = {
        'username': usernameController.text,
        'password': passwordController.text
      };
      var response = await Dio().post('$url/register', data: requestModel);

      if (response.statusCode == 201) {
        alertAuthSuccess(context, response.data['message']);

        _sharedPref.setInt('id', response.data['data']['id']);
        _sharedPref.setString('username', response.data['data']['username']);
      } else {
        alertAuthFailed(context, response.data['message']);
      }
    } on DioException catch (e) {
      alertAuthFailed(context, 'Error: ${e.message}');
    }

    notifyListeners();
  }

  // FUTURE DETAIL USER BY  ID
  Future detailUser(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();
    try {
      var id = _sharedPref.getInt('id');
      var response = await Dio().get('$url/users/$id');

      // SET PREFERENCE IMAGE
      if (response.data['data']['image'] != null) {
        // _sharedPref.setString('image', response.data['data']['image']);
        var image = response.data['data']['image'];
        _sharedPref.setString('image', '$url/public/images/$image');
      }
    } on DioException catch (e) {
      alertAuthFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  Future updatePassword(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();
    try {
      var id = _sharedPref.getInt('id');
      if (id != null) {
        if (passwordController.text.isNotEmpty) {
          var requestModel = {'password': passwordController.text};
          var response =
              await Dio().patch('$url/users/$id', data: requestModel);
          if (response.statusCode == 200) {
            alertAuthSuccess(context, response.data['message']);
          } else {
            alertAuthFailed(context, response.data['message']);
          }
        } else {
          showAlertFieldEmpty(context);
        }
      } else {
        alertAuthFailed(context, 'User ID not found. Please log in again.');
      }
    } on DioException catch (e) {
      alertAuthFailed(context, 'Error: ${e.message}');
    }
    notifyListeners();
  }

  // ==========================================================================================
  // FUNGSI UNTUK ALERT SUCCESS
  // ==========================================================================================
  void alertAuthSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline,
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
              onPressed: () {
                if (formTitle == 'Sign In') {
                  usernameController.clear();
                  passwordController.clear();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        username: _sharedPref.getString('username'),
                      ),
                    ),
                  );
                } else if (formTitle == 'Sign Up') {
                  usernameController.clear();
                  passwordController.clear();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        username: _sharedPref.getString('username'),
                      ),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================================================
  // FUNGSI UNTUK ALERT FAILED
  // ==========================================================================================
  void alertAuthFailed(BuildContext context, String message) {
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
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================================================
  //  FUNCTION FOR HIDE AND SHOW PASSWORD
  // ==========================================================================================
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
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

enum StateAuth { initial, loading, success, error }
