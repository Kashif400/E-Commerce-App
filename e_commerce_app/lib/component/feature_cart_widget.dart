import 'package:e_commerce_app/View/category/category_detail.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featureCart({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
    Get.to(CategoryDetail(title: title));
  });
}
