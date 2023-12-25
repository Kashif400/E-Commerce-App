import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/colors.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

//DocumentSnapshot data
Widget messageBuble() {
  var t = DateTime.now();
  // var t =
  //     data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  // var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection: TextDirection.rtl,
    // data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            // color: data['uid'] == currentUser!.uid ? redColor : fontGrey,
            color: purpleColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "hi".text.white.size(16).make(),
            '10:30 pm'.text.color(Colors.white.withOpacity(0.5)).make()
          ]),
        ),
      ],
    ),
  );
}
