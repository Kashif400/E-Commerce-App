import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialogBox(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Confirm'.text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 60,
                child: RoundButton(
                    title: 'Yes',
                    onTap: () {
                      SystemNavigator.pop();
                    })),
            SizedBox(
                width: 60,
                child: RoundButton(
                    title: 'No',
                    onTap: () {
                      Navigator.pop(context);
                    }))
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).rounded.make(),
  );
}
