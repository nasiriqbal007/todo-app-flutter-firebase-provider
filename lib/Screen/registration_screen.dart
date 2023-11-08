// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/Provider/auth_provider.dart';
import 'package:todo_app/Screen/login_screen.dart';

import 'package:todo_app/Widgets/customButtons.dart';
import 'package:todo_app/Widgets/textfield_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegistrationScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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

  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 560,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Colors.amberAccent,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            autofocus: true,
                            controller: userNameController,
                            decoration:
                                CustomInputDecoration(labelText: "Username"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "form must not be empty";
                              } else {}
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            decoration: CustomInputDecoration(
                                labelText: "Phone Number"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "form must not be empty ";
                              }
                              if (value.length < 11) {
                                return "Provide a valid phone number.";
                              } else {}
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            autofocus: true,
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
                                await authProvider.signUp(
                                    userNameController.text.trim(),
                                    phoneNumberController.text.trim(),
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                                Navigator.pop(context);
                                if (authProvider.currentUser != null) {
                                  Navigator.pop(context);
                                  Get.to(const LoginScreen());
                                }
                              } else {}
                            },
                            text: 'Register',
                            buttonColor: Colors.amber,
                            buttonWidth: 340,
                          ),
                          SizedBox(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
                                TextButton(
                                    onPressed: () {
                                      Get.to(const LoginScreen());
                                    },
                                    child: const Text(
                                      "Login",
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
          ],
        ),
      ),
    );
  }
}
