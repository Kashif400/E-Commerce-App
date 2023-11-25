import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/colors.dart';
import '../consts/styles.dart';

Widget cartWidget({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      Expanded(
          child:
              title!.text.color(darkFontGrey).align(TextAlign.center).make()),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
