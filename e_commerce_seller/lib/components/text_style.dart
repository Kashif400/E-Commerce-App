import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget normalText({text, color = Colors.white, size = 14.0}) {
  return '$text'.text.color(color).size(size).make();
}

Widget boldText({text, color = Colors.white, size = 14.0}) {
  return '$text'.text.color(color).semiBold.size(size).make();
}
