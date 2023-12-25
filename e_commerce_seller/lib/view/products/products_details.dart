import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_seller/const/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';

class ProductsDetails extends StatelessWidget {
  final dynamic data;
  const ProductsDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title:
              boldText(text: '${data['p_name']}', color: fontGrey, size: 16.0),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title and details section
                  boldText(
                      text: '${data['p_name']}', color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: '${data['p_category']}',
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: '${data['p_subcategory']}',
                          color: fontGrey,
                          size: 16.0)
                    ],
                  ),
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
                  boldText(
                      text: '\$${data['p_price']}', size: 18.0, color: red),
                  10.heightBox,

                  //color section
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color: ", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index]))
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {}),
                            ),
                          )
                        ],
                      ),

                      10.heightBox,
                      //quantity row
                      Row(children: [
                        SizedBox(
                          width: 100,
                          child: boldText(text: "Quantity: ", color: fontGrey),
                        ),
                        normalText(
                            text: '${data['p_quantity']} items',
                            color: fontGrey)
                      ]),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  const Divider(),
                  boldText(text: 'Description', color: fontGrey),
                  10.heightBox,
                  normalText(text: '${data['p_description']}', color: fontGrey)
                ],
              ),
            )
          ]),
        ));
  }
}
