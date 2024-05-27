import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_management_system/providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    var authProvider = context.watch<AuthProvider>();
    return Scaffold(
        body: Form(
            key: authProvider.formAuthentication,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: sizeScreen.width,
              height: sizeScreen.height,
              color: Colors.orange,
              child: SizedBox(
                width: sizeScreen.width,
                height: sizeScreen.height * 0.65,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        authProvider.formTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Enter your email and password to ${authProvider.formTitle.toLowerCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: sizeScreen.width,
                      height: sizeScreen.height * 0.5,
                      color: Colors.white,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 50),
                        children: [
                          TextFormField(
                            controller: authProvider.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: authProvider.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: authProvider.obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authProvider.changeObscurePassword();
                                  },
                                  icon: Icon(authProvider.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onPressed: () {
                              if (authProvider.formAuthentication.currentState!
                                  .validate()) {
                                authProvider.formTitle == 'Sign In'
                                    ? authProvider.processLogin(context)
                                    : authProvider.showAlertFieldEmpty(context);
                              } else {
                                authProvider.showAlertFieldEmpty(context);
                              }
                            },
                            child: Text(authProvider.formTitle),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              onPressed: () {
                                authProvider.updateFormTitle();
                              },
                              child: Text(
                                authProvider.formTitle == 'Sign In'
                                    ? 'I don\'t have an account ? Sign Up'
                                    : 'I have an account ? Sign In',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
