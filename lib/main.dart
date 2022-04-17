import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socially/screen/login.dart';
import 'package:socially/screen/splash.dart';
import 'package:socially/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
    .then((_) {
      runApp(const MyApp());
    });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socially',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      //themeMode: ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}
