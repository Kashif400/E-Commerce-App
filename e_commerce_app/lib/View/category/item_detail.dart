import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final dynamic data;
  final String? title;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return PopScope(
      canPop: true,
      onPopInvoked: (bool isDidPop) async {
        controller.restValue();
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              controller.restValue();
            },
          ),
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_images'].length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: data['p_images'][index],
                            width: double.infinity,
                            // height: 200,
                            fit: BoxFit.cover,
                          );
                        }),

                    10.heightBox,

                    //title and details section
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),

                    10.heightBox,
                    //rating
                    VxRating(
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      count: 5,
                      maxRating: 5,
                    ),

                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),

                    10.heightBox,

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make()
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5))
                        .color(textfieldGrey)
                        .make(),

                    //color section
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                    data['p_colors'][index]))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: "
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(children: [
                                IconButton(
                                    onPressed: () {
                                      controller.decQuantity();

                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.remove)),
                                controller.quantity.value.text
                                    .size(16)
                                    .color(darkFontGrey)
                                    .fontFamily(bold)
                                    .make(),
                                IconButton(
                                    onPressed: () {
                                      controller.incQuantity(
                                          int.parse(data['p_quantity']));

                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: const Icon(Icons.add)),
                                10.widthBox,
                                "( ${data['p_quantity']} available)"
                                    .text
                                    .color(textfieldGrey)
                                    .make()
                              ]),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(textfieldGrey).make(),
                              ),
                              Row(children: [
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ]),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_description']}".text.color(darkFontGrey).make(),

                    //button section
                    10.heightBox,
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                          itemBtnList.length,
                          (index) => ListTile(
                                title: itemBtnList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),

                    //products may you like section
                    20.heightBox,
                    productsyoumaylike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 8GB/500GB"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$800"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .white
                                    .roundedSM
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            RoundButton(
              title: 'Add to Cart',
              onTap: () async {
                controller.addToCart(
                    title: data['p_name'],
                    image: data['p_images'][1],
                    sellername: data['p_seller'],
                    color: data['p_colors'][controller.colorIndex.value],
                    tprice: controller.totalPrice.value,
                    qty: controller.quantity.value,
                    context: context);
                VxToast.show(context, msg: 'add to card');
              },
              textColor: whiteColor,
              btnColor: redColor,
            )
          ],
        ),
      ),
    );
  }
}
