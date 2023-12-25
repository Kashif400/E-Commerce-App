import 'package:e_commerce_seller/components/custom_textfield.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/strings.dart';

class ShopSettingView extends StatelessWidget {
  const ShopSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: white,
              )),
          title: boldText(text: shopsetting, size: 16.0),
          actions: [
            controller.isLoading.value
                ? CircularProgressIndicator(color: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      controller.updateShop(
                          shopaddress:
                              controller.shopAddressController.text.trim(),
                          shopdescription:
                              controller.shopDescriptionController.text.trim(),
                          shopmobile:
                              controller.shopMobileController.text.trim(),
                          shopname: controller.shopNameController.text.trim(),
                          shopwebsite:
                              controller.shopWebsiteController.text.trim());
                      VxToast.show(context, msg: 'Update');
                    },
                    child: normalText(text: 'Save'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextfield(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextfield(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextfield(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextfield(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextfield(
                  label: description,
                  hint: shopDescHint,
                  isDescr: true,
                  controller: controller.shopDescriptionController),
            ],
          ),
        ),
      ),
    );
  }
}
