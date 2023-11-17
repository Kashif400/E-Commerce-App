import 'package:e_commerce_app/component/applogo_widget.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
            Spacer(),
            Text(
              credits.toString(),
              style: TextStyle(fontFamily: semibold, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
