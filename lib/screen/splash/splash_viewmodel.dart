import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socially/screen/auth_screen/login/login_view.dart';
import 'package:socially/screen/chat_home/chat_home_view.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final user = FirebaseAuth.instance.currentUser;
  Future<void> start(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatHomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }
}
