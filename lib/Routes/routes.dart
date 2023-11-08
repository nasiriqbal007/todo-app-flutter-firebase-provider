// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:todo_app/Screen/home_screen.dart';
import 'package:todo_app/Screen/login_screen.dart';
import 'package:todo_app/Screen/onboarding_screen.dart';
import 'package:todo_app/Screen/registration_screen.dart';
import 'package:todo_app/Screen/splash_screen.dart';
import 'package:todo_app/Screen/task_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String onboardingScreen = '/onboardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String registrationScreen = '/registrationScreen';
  static const String homeScreen = '/homeScreen';
  static const String taskScreen = '/taskScreen';

  static List<GetPage> all = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: registrationScreen, page: () => RegistrationScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: taskScreen, page: () => TaskScreen()),
  ];
}
