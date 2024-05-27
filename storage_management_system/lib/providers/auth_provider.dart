import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_management_system/screens/main_screen.dart';

class AuthProvider extends ChangeNotifier {
  // PREFERENCE
  late SharedPreferences _sharedPref;

  // GLOBAL STATE
  final formAuthentication = GlobalKey<FormState>();
  StateAuth authState = StateAuth.initial;

  // TEXT CONTROLLERS
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // VARIABLES
  var formTitle = 'Sign In';
  var email = '';
  var password = '';
  var messageError = '';
  bool obscurePassword = true;

// FOR UPDATE FORM TITLE
  void updateFormTitle() {
    if (formTitle == 'Sign In') {
      formTitle = 'Sign Up';
      emailController.clear();
      passwordController.clear();
    } else {
      formTitle = 'Sign In';
      passwordController.clear();
    }

    notifyListeners();
  }

// FOR PROCESS LOGIN
  void processLogin(BuildContext context) async {
    // INITIALIZE PREFERENCE
    _sharedPref = await SharedPreferences.getInstance();

    if (emailController.text == 'admin' &&
        passwordController.text == 'administrator') {
      authState = StateAuth.success;
      alertAuthSuccess(context, 'Login Success');

      // SAVE DATA TO PREFERENCE
      _sharedPref.setString('email', emailController.text);
    } else {
      authState = StateAuth.error;
      alertAuthFailed(context, 'Credentials Invalid');
    }

    notifyListeners();
  }

// FOR ALERT IF AUTH SUCCESS
  void alertAuthSuccess(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_circle_outline,
              color: Colors.green, size: 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          title: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (formTitle == 'Sign In') {
                  emailController.clear();
                  passwordController.clear();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(
                              email: _sharedPref.getString('email'),
                            )),
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
    notifyListeners();
  }

// FOR ALERT IF AUTH FAILED
  void alertAuthFailed(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error_outline_rounded,
              color: Colors.red, size: 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          title: Text(
            message,
            textAlign: TextAlign.center,
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
    notifyListeners();
  }

// FOR TOGGLE OBSCURE PASSWORD
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

// FOR ALERT IF FIELD EMPTY
  void showAlertFieldEmpty(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error_outline, color: Colors.red, size: 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          title: const Text(
            'Please fill in the fields',
            textAlign: TextAlign.center,
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
