import 'package:e_commerce_app/View/category/category_detail.dart';
import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/styles.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidght(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: 9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 180),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    categoryImageList[index],
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  categoriesList[index]
                      .text
                      .align(TextAlign.center)
                      .color(darkFontGrey)
                      .make()
                ],
              )
                  .box
                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                  .white
                  .roundedSM
                  .clip(Clip.antiAlias)
                  .outerShadowSm
                  .make()
                  .onTap(() {
                controller.getSubCategories(title: categoriesList[index]);

                Get.to(CategoryDetail(
                  title: categoriesList[index],
                ));
              });
            }),
      ),
    ));
  }
}
