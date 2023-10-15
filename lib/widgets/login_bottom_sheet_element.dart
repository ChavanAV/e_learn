import 'package:e_learn/Screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/splash_screen.dart';
import '../method_provider/auth_method.dart';
import '../utils/decoration.dart';
import '../utils/toast_msg.dart';
import 'data_input_field.dart';

class LoginBottomSheetElement extends StatefulWidget {
  const LoginBottomSheetElement({super.key});

  @override
  State<LoginBottomSheetElement> createState() =>
      _LoginBottomSheetElementState();
}

class _LoginBottomSheetElementState extends State<LoginBottomSheetElement> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool obscure = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      String res = await AuthMethod().loginUsers(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        pop();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Utils().toastMsg("Enter all fields");
      setState(() {
        isLoading = false;
      });
    }
  }

  void pop() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: (size.width < 600) ? size.height - 200 : size.height - 10,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ));
                          },
                          child: const Text(
                            "Create an account",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DataInput(
                        labelText: "Enter Email Address",
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: orangeColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          labelText: "Enter Password",
                          labelStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.all(15),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                            icon: obscure
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter password";
                          } else {
                            return null;
                          }
                        },
                        obscureText: !obscure,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  loginUser();
                }
              },
              child: isLoading
                  ? const LinearProgressIndicator()
                  : const Text(
                      "Login",
                    ),
            ),
            const SizedBox(
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}
