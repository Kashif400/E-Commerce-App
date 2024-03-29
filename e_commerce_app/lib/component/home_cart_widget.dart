import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeCardWidget({height, width, icon, String? title, onPressed}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).size(10).make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
