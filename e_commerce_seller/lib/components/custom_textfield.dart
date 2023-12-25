import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/strings.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

Widget customTextfield({label, hint, controller, isDescr = false}) {
  return TextFormField(
    maxLines: isDescr ? 4 : 1,
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        hintText: hint,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(
          color: lightGrey,
        )),
  );
}
