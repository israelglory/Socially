// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socially/screen/auth_screen/login/login_viewmodel.dart';

import 'package:socially/screen/auth_screen/sign_up/register_view.dart';
import 'package:socially/screen/chat_home/chat_home_view.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blue,
                                        //Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextField(
                                      controller: model.emailController,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "Email address",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextField(
                                      controller: model.passController,
                                      obscureText: model.show,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.blue,
                                          ),
                                          suffixIcon: model.show == true
                                              ? InkWell(
                                                  onTap: () {
                                                    model.onObscure();
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons.eye_fill,
                                                  ))
                                              : InkWell(
                                                  onTap: () {
                                                    model.onhide();
                                                  },
                                                  child: const Icon(
                                                    CupertinoIcons
                                                        .eye_slash_fill,
                                                  ),
                                                ),
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                model.login(context);
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue),
                                child: Center(
                                  child: Visibility(
                                    visible: !model.inProgress,
                                    replacement: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Container(
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
