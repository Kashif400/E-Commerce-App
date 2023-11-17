import 'package:e_commerce_app/consts/images.dart';
import 'package:flutter/material.dart';

Widget bgWidght({Widget? child}) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              imgBackground,
            ),
            fit: BoxFit.fill)),
    child: child,
  );
}
