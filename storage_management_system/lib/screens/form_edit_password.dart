import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/providers/auth_provider.dart';

class FormEditPassword extends StatefulWidget {
  final id;
  const FormEditPassword({super.key, this.id});

  @override
  State<FormEditPassword> createState() => _FormEditPasswordState();
}

class _FormEditPasswordState extends State<FormEditPassword> {
  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.key),
        title: const Text('Change Password'),
      ),
      body: Form(
        key: authProvider.formAuthentication,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: ListView(
            children: [
              TextFormField(
                controller: authProvider.passwordController,
                obscureText: authProvider.obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authProvider.obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      authProvider.changeObscurePassword();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (authProvider.formAuthentication.currentState!
                      .validate()) {
                    authProvider.updatePassword(context);
                  }
                },
                child: const Text('Change Password'),
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
    );
  }
}
