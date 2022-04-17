// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:socially/screen/login.dart';
import 'package:socially/screen/messages.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:socially/screen/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DelayedDisplay(
              delay: const Duration(seconds: 3),
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
              delay: const Duration(seconds: 3),
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
              delay: const Duration(seconds: 3),
              child: Container(
                child: Image.asset(
                  "images/spimg.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: BouncingWidget(
                scaleFactor: 1.5,
                duration: const Duration(milliseconds: 100),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
