import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/auth/login_view.dart';
import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/View/seller_view.dart';
import 'package:e_commerce_app/component/applogo_widget.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  splashservices() async {
    if (currentUser != null) {
      await Future.delayed(const Duration(seconds: 2), () async {
        await firestore
            .collection(userCollection)
            .doc(currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists &&
              documentSnapshot.get('seller_type') == false) {
            Get.to(const Home());
          } else {
            //  Get.to(const SellerView());
          }
        });
      });
    } else {
      Get.to(LoginView());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            /* AppLogoWidget(), */
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            const SizedBox(
              height: 20,
            ),
            AppLogoWidget(),
            Text(appname.toString(),
                style: const TextStyle(
                    fontFamily: bold, color: Colors.white, fontSize: 22)),
            const Spacer(),
            Text(
              credits.toString(),
              style: const TextStyle(fontFamily: semibold, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
