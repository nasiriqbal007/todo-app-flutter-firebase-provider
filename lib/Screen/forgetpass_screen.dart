import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Provider/auth_provider.dart';
import 'package:todo_app/Routes/routes.dart';
import 'package:todo_app/Screen/login_screen.dart';
import 'package:todo_app/Widgets/customButtons.dart';
import 'package:todo_app/Widgets/textfield_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
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
                    height: 250,
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
                            const SizedBox(
                              height: 20,
                            ),
                            CustomElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  authprovider
                                      .resetPassword(emailController.text);
                                  Get.to(const LoginScreen());
                                }
                              },
                              text: 'Reset Password',
                              buttonColor: Colors.amber,
                              buttonWidth: 340,
                            ),
                            SizedBox(
                              height: 32,
                              child: TextButton(
                                  onPressed: () {
                                    Get.offAllNamed(AppRoutes.loginScreen);
                                  },
                                  child: const Text("Login Screen?")),
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
