import 'package:e_commerce_app/View/Cart/payment_method.dart';
import 'package:e_commerce_app/component/custom_textfield.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingDetail extends StatelessWidget {
  const ShippingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Shipping Info'.text.fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: RoundButton(
              title: 'Continue',
              onTap: () {
                if (controller.addressController.text.length > 10) {
                  Get.to(const PaymentMethod());
                } else {
                  VxToast.show(context, msg: 'Please fill the form');
                }
              })),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextField(
                  hint: 'Address',
                  isPass: false,
                  title: 'Address',
                  controller: controller.addressController),
              customTextField(
                  hint: 'City',
                  isPass: false,
                  title: 'City',
                  controller: controller.cityController),
              customTextField(
                  hint: 'State',
                  isPass: false,
                  title: 'State',
                  controller: controller.stateController),
              customTextField(
                  hint: 'Postal Code',
                  isPass: false,
                  title: 'Postal Code',
                  controller: controller.postalCodeController),
              customTextField(
                  hint: 'Phone',
                  isPass: false,
                  title: 'Phone',
                  controller: controller.phoneController),
            ],
          ),
        ),
      ),
    );
  }
}
