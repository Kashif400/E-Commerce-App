import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBuble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : fontGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        "${data['msg']}".text.white.size(16).make(),
        time.text.color(whiteColor.withOpacity(0.5)).make()
      ]),
    ),
  );
}
