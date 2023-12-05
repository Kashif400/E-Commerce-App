import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/category/item_detail.dart';
import 'package:e_commerce_app/View/home/search_view.dart';
import 'package:e_commerce_app/component/feature_cart_widget.dart';
import 'package:e_commerce_app/component/home_cart_widget.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: double.infinity,
      height: double.infinity,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
            child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController.value,
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      Get.to(SearchView(
                        title: controller.searchController.value.text,
                      ));
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAnyThing,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //swipers brand
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(sliderList[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    //deal button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          2,
                          (index) => homeCardWidget(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayDeal : flashSale,
                              onPressed: () {})),
                    ),

                    //second swipers brand
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(secondSliderList[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,
                    //category button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => homeCardWidget(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.5,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSalers,
                              onPressed: () {})),
                    ),

                    //feature category
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featureCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    20.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featureCart(
                                        icon: featuredImage1[index],
                                        title: featuredTitle1[index]),
                                    10.heightBox,
                                    featureCart(
                                        icon: featuredImage2[index],
                                        title: featuredTitle2[index]),
                                  ],
                                )),
                      ),
                    ),

                    //Featured Product
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return 'No Featured Product'
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    featuredData[index]
                                                        ['p_images'][0],
                                                    width: 130,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_name']}"
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(darkFontGrey)
                                                      .make(),
                                                  10.heightBox,
                                                  "\$${featuredData[index]['p_price']}"
                                                      .text
                                                      .color(redColor)
                                                      .fontFamily(bold)
                                                      .size(16)
                                                      .make()
                                                ],
                                              )
                                                  .box
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .white
                                                  .roundedSM
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(ItemDetails(
                                                  title: featuredData[index]
                                                      ['p_name'],
                                                  data: featuredData[index],
                                                ));
                                              })),
                                    );
                                  }
                                },
                              )),
                        ],
                      ),
                    ),
                    //third swipers brand
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(secondSliderList[index],
                                  fit: BoxFit.fill)
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,

                    // all product
                    Align(
                      alignment: Alignment.centerLeft,
                      child: 'All Products'
                          .text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var allproducts = snapshot.data!.docs;
                          return GridView.builder(
                              itemCount: allproducts.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: allproducts[index]['p_images']
                                            [0],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    "${allproducts[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$${allproducts[index]['p_price']}"
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
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(ItemDetails(
                                    title: allproducts[index]['p_name'],
                                    data: allproducts[index],
                                  ));
                                });
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
