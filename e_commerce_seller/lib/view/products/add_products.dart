import 'package:e_commerce_seller/components/custom_textfield.dart';
import 'package:e_commerce_seller/components/products_dropdown.dart';
import 'package:e_commerce_seller/components/products_images.dart';
import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {},
              icon: const Icon(
                Icons.arrow_back,
                color: white,
              )),
          title: boldText(text: 'Add Products', size: 16.0),
          actions: [
            controller.isloading.value
                ? const CircularProgressIndicator(
                    color: white,
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProducts(context);
                      Get.back();
                    },
                    child: boldText(text: 'Save'),
                  ),
            5.widthBox
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextfield(
                    hint: 'eg. BMW',
                    label: 'Product Name',
                    controller: controller.pnameController),
                10.heightBox,
                customTextfield(
                    hint: 'eg. Nice Products',
                    label: 'Description',
                    isDescr: true,
                    controller: controller.pdesController),
                10.heightBox,
                customTextfield(
                    hint: 'eg. \$100',
                    label: 'Price',
                    controller: controller.ppriceController),
                10.heightBox,
                customTextfield(
                    hint: 'eg. 20',
                    label: 'Quantity',
                    controller: controller.pquantityController),
                10.heightBox,
                productDropdown(
                    hint: 'Category',
                    list: controller.categoryList,
                    dropvalue: controller.categoryvalue,
                    controller: controller),
                10.heightBox,
                productDropdown(
                    hint: 'Subcategory',
                    list: controller.subcategoryList,
                    dropvalue: controller.subcategoryvalue,
                    controller: controller),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                boldText(text: 'Choose Product Images'),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                                .box
                                .roundedSM
                                .clip(Clip.antiAlias)
                                .make()
                                .onTap(() {
                                controller.pickImage(index, context);
                              })
                            : ProductImages(label: '${index + 1}').onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: 'First Image will be your display image',
                    color: lightGrey),
                const Divider(
                  color: white,
                ),
                10.heightBox,
                boldText(text: 'Choose Product Colors'),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        itemColors.length,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(itemColors[index])
                                    .roundedFull
                                    .size(50, 50)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? Icon(
                                        Icons.done,
                                        color: itemColors[index] == Colors.black
                                            ? Colors.white
                                            : Colors.black,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
