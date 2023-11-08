import 'package:flutter/material.dart';
import 'package:todo_app/Screen/home_screen.dart';
import 'package:todo_app/Screen/login_screen.dart';
import 'package:todo_app/Screen/onboarding_screen.dart';
import 'package:todo_app/Utils/user_status.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initNavigation();
  }

  void _initNavigation() {
    _timer = Timer(const Duration(milliseconds: 3500), () {
      navigateBasedOnUserStatus();
    });
  }

  void navigateBasedOnUserStatus() async {
    bool isFirstTime = await UserStatusChecker.isFirstTimeUser();
    bool loggedIn = await UserStatusChecker.isLoggedIn();

    if (mounted) {
      if (isFirstTime) {
        _navigateToScreen(const OnboardingScreen());
      } else if (loggedIn) {
        _navigateToScreen(const HomeScreen());
      } else {
        _navigateToScreen(const LoginScreen());
      }
    }
  }

  void _navigateToScreen(Widget screen) {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // Replace this with your Splash Screen content

          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/giphy.gif',
          )),
    );
  }
}
