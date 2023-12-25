import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/components/dashboard_button.dart';
import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:e_commerce_seller/const/images.dart';
import 'package:e_commerce_seller/const/strings.dart';
import 'package:e_commerce_seller/services/firestore_services.dart';
import 'package:e_commerce_seller/view/products/products_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intel;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: dashboard, color: fontGrey, size: 16.0),
          actions: [
            Center(
              child: normalText(
                  text: intel.DateFormat('EE, MMM d,' 'yy')
                      .format(DateTime.now()),
                  color: purpleColor,
                  size: 14.0),
            ),
            10.widthBox
          ],
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: purpleColor,
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: '${data.length}',
                            icon: icProducts),
                        dashboardButton(context,
                            title: 'Orders', count: '15', icon: icOrders)
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dashboardButton(context,
                            title: 'Rating', count: '60', icon: icStar),
                        dashboardButton(context,
                            title: 'Total Sales', count: '15', icon: icOrders)
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(
                        text: 'Popular Products', color: fontGrey, size: 16.0),
                    20.heightBox,
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,

                            //products is wishlist to show product and is not wishlist product to show sizedbox

                            (index) => data[index]['p_wishlist'].length == 0
                                ? const SizedBox.shrink()
                                : ListTile(
                                    onTap: () {
                                      Get.to(ProductsDetails(
                                        data: data[index],
                                      ));
                                    },
                                    leading: Image.network(
                                      data[index]['p_images'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                        text: data[index]['p_name'],
                                        color: fontGrey,
                                        size: 14.0),
                                    subtitle: boldText(
                                        text: '\$${data[index]['p_price']}',
                                        color: darkGrey,
                                        size: 16.0),
                                  )),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
