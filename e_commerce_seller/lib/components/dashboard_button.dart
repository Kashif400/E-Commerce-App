import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/colors.dart';
import '../const/images.dart';
import '../const/strings.dart';
import 'text_style.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.sizeOf(context);
  return Row(
    children: [
      // ignore: prefer_const_constructors
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boldText(text: title, size: 16.0),
            boldText(text: count, size: 20.0)
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: white,
      )
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(4))
      .make();
}
