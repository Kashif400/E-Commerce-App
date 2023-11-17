import 'package:e_commerce_app/consts/images.dart';
import 'package:flutter/material.dart';

Widget AppLogoWidget() {
  return Container(
    width: 77,
    height: 77,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Image.asset(icAppLogo),
  );
}
