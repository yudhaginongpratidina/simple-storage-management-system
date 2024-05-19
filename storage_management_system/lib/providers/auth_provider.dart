import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
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
    if (emailController.text == 'admin' &&
        passwordController.text == 'administrator') {
      authState = StateAuth.success;
      alertAuthSuccess(context, 'Login Success');
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
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
