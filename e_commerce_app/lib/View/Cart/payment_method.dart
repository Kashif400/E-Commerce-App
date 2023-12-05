import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/styles.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title:
            'Choose Payment Method'.text.fontFamily(semibold).size(18).make(),
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(
          () => RoundButton(
              loading: controller.placeingOrder.value,
              title: 'Place my order',
              onTap: () async {
                await controller.placeMyOrder(
                    orderPaymentMthod:
                        paymentMethodList[controller.paymentIndex.value],
                    totalAmount: controller.totalPrice.value);
                await controller.clearCart();
                VxToast.show(context, msg: 'Order placed successfully');
                Get.offAll(const Home());
              }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => Column(
            children: List.generate(paymentMethodList.length, (index) {
              return InkWell(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4)),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImgList[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  value: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  onChanged: (value) {}))
                          : const SizedBox.shrink(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethodList[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make())
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
