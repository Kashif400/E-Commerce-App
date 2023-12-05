import 'package:e_commerce_app/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatusWidget({icon, color, title, showDone, context}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: MediaQuery.sizeOf(context).width * .35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          '$title'.text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container()
        ],
      ),
    ),
  );
}
