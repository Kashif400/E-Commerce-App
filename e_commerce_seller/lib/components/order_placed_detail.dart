import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlacedDetaileWidget({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: '$title1', color: purpleColor),
            boldText(text: '$d1', color: red),

            // '$title1'.text.fontFamily(semibold).make(),
            // '$d1'.text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: '$title2', color: purpleColor),
              boldText(text: '$d2', color: red),
              // '$title2'.text.fontFamily(semibold).make(),
              // '$d2'.text.make()
            ],
          ),
        )
      ],
    ),
  );
}