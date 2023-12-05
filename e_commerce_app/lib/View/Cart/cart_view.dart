import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/Cart/shipping_view.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/cart_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 60,
            child: RoundButton(
                title: 'Proceed to shipping',
                onTap: () {
                  Get.to(const ShippingDetail());
                })),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: 'Shopping cart'
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: 'Cart is Empty'.text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;

              controller.calculate(data);
              controller.productSnapshot = data;

              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Image.network(
                                  '${data[index]['image']}',
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title:
                                    '${data[index]['title']} (x${data[index]['qty']})'
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: '${data[index]['tprice']}'
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => '${controller.totalPrice.value}'
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make()),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGolden)
                        .roundedSM
                        .make(),
                    10.heightBox,
                  ],
                ),
              );
            }
          },
        ));
  }
}
