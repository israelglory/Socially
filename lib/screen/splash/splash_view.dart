// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:socially/screen/auth_screen/login/login_view.dart';
import 'package:socially/screen/chat_home/chat_home_view.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:socially/screen/auth_screen/sign_up/register_view.dart';
import 'package:socially/screen/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (model) async {
        await model.start(context);
      },
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DelayedDisplay(
                    fadingDuration: const Duration(seconds: 1),
                    delay: const Duration(seconds: 1),
                    fadeIn: true,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: const Text(
                        'Welcome To',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  DelayedDisplay(
                    fadingDuration: const Duration(seconds: 2),
                    delay: const Duration(seconds: 2),
                    fadeIn: true,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: const Text(
                        'Socially',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  FadeInRight(
                    animate: true,
                    delay: const Duration(seconds: 2),
                    child: Container(
                      child: Image.asset(
                        "images/spimg.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
