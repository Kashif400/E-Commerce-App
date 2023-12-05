import 'package:e_commerce_app/View/auth/login_view.dart';
import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'consts/colors.dart';
import 'consts/strings.dart';
import 'consts/styles.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: darkFontGrey),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          fontFamily: regular),
      // home: currentUser != null ? const Home() : const LoginView(),
      home: LoginView(),
    );
  }
}
