import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/product_controller.dart';

Widget productDropdown(
    {hint, List<String>? list, dropvalue, ProductController? controller}) {
  return Obx(
    () => Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
            hint: boldText(text: "$hint", color: fontGrey),
            value: dropvalue.value == '' ? null : dropvalue.value,
            items: list!.map((e) {
              return DropdownMenuItem(
                value: e,
                child: e.toString().text.make(),
              );
            }).toList(),
            onChanged: (newValue) {
              if (hint == 'Category') {
                controller!.subcategoryvalue.value = '';
                controller.populateSubcategoryList(newValue.toString());
              }
              dropvalue.value = newValue.toString();
            },
          ))
              .box
              .white
              .padding(EdgeInsets.symmetric(horizontal: 4))
              .roundedSM
              .make(),
        ),
      ],
    ),
  );
}
