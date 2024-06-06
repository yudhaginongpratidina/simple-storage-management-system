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
  void processLogin(BuildContext context) async {
    _sharedPref = await SharedPreferences.getInstance();

    try {
      var requestModel = {
        'username': usernameController.text,
        'password': passwordController.text
      };

      var response =
          await Dio().post('http://192.168.1.5:3000/login', data: requestModel);

      if (response.statusCode == 200 &&
          response.data['message'] == 'Login Success') {
        _sharedPref.setInt('id', response.data['data']['id']);
        _sharedPref.setString('username', response.data['data']['username']);
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
      var response = await Dio()
          .post('http://192.168.1.5:3000/register', data: requestModel);

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
