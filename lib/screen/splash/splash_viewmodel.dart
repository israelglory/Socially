import 'package:flutter/material.dart';
import 'package:socially/screen/auth_screen/login/login_view.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> start(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
