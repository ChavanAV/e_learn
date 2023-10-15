import 'dart:typed_data';

import 'package:e_learn/Screens/splash_screen.dart';
import 'package:e_learn/utils/toast_msg.dart';
import 'package:flutter/material.dart';

import '../method_provider/auth_method.dart';
import '../method_provider/methods.dart';
import '../utils/decoration.dart';
import '../widgets/data_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  bool obscure = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void selectImg() async {
    Uint8List img = await MethodProvider().pickImage();
    setState(() {
      _image = img;
    });
  }

  void signUpUsers() async {
    if (usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _image != null) {
      setState(() {
        isLoading = true;
      });
      String ref = await AuthMethod().signUpUsers(
        userName: usernameController.text.toString(),
        userEmail: emailController.text.toString(),
        password: passwordController.text.toString(),
        file: _image!,
      );

      if (ref == "success") {
        String loginRes = await AuthMethod().loginUsers(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        );
        if (loginRes == "success") {
          setState(() {
            isLoading = false;
          });
          navigateToExplorePage();
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Utils().toastMsg("Enter All Details");
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToExplorePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Stack(
                children: [
                  (_image != null)
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCgMjPKAhhS9PH4nS3n84mqgzbBKZdSdacYm4Sa0qqBcdKTys1yCDQqulbq4dLB860XQ4&usqp=CAU"),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          selectImg();
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DataInput(
                          labelText: "Enter User Name",
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: 30,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelText: "Enter Password",
                            labelStyle: const TextStyle(color: Colors.grey),
                            hintText: "Enter more than 6 character password",
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
                          cursorColor: Colors.grey,
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
                    signUpUsers();
                  }
                },
                child: isLoading
                    ? const LinearProgressIndicator()
                    : const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
