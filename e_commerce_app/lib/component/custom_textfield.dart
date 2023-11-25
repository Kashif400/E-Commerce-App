import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/styles.dart';

Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
            fontFamily: semibold, fontSize: 16, color: redColor),
      ),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                const TextStyle(fontFamily: semibold, color: textfieldGrey),
            isDense: true,
            filled: true,
            fillColor: lightGrey,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      const SizedBox(
        height: 5,
      )
    ],
  );
}
