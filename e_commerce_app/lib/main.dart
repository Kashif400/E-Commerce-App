import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/View/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/auth/login_view.dart';
import 'View/auth/signup_view.dart';
import 'consts/strings.dart';
import 'consts/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          fontFamily: regular),
      home: const Home(),
    );
  }
}
