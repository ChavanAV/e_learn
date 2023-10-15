import 'dart:async';

import 'package:e_learn/method_provider/methods.dart';
import 'package:e_learn/resources/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    addData();
    MethodProvider().refreshAllUserData();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        moveToExplorePage();
      }
    });
    super.initState();
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  void moveToExplorePage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage("assets/images/app_logo.png")),
      ),
    );
  }
}
