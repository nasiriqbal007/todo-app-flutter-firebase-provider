// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/auth_provider.dart';
import 'package:todo_app/Routes/routes.dart';
import 'package:todo_app/Screen/forgetpass_screen.dart';
import 'package:todo_app/Screen/registration_screen.dart';
import 'package:todo_app/Widgets/customButtons.dart';
import 'package:todo_app/Widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    Future<void> _showLoading() async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 350,
                    child: Card(
                      color: Colors.amberAccent,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration:
                                  CustomInputDecoration(labelText: "Email"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "form must not be empty ";
                                }
                                final regexp = RegExp(r'^[a-zA-Z0-9]+$');
                                if (regexp.hasMatch(value)) {
                                  return "Please enter valid email";
                                } else {}
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration:
                                  CustomInputDecoration(labelText: "Password"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "form must not be empty ";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long.";
                                } else {}
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _showLoading();

                                  await authProvider
                                      .signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  )
                                      .then((user) {
                                    if (user != null) {
                                      Get.offAllNamed(AppRoutes.homeScreen);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              text: 'Login',
                              buttonColor: Colors.amber,
                              buttonWidth: 340,
                            ),
                            SizedBox(
                              height: 32,
                              child: TextButton(
                                  onPressed: () {
                                    Get.to(const ForgetPassword());
                                  },
                                  child: const Text("ForgetPassword?")),
                            ),
                            SizedBox(
                              height: 32,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?"),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(const RegistrationScreen());
                                      },
                                      child: const Text(
                                        "SignUp",
                                        style: TextStyle(fontSize: 16),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
