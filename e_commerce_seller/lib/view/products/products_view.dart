import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:e_commerce_seller/const/lists.dart';
import 'package:e_commerce_seller/controller/product_controller.dart';
import 'package:e_commerce_seller/services/firestore_services.dart';
import 'package:e_commerce_seller/view/products/add_products.dart';
import 'package:e_commerce_seller/view/products/products_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/strings.dart';
import 'package:intl/intl.dart' as intel;

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: purpleColor,
            child: const Icon(
              Icons.add,
              color: white,
            ),
            onPressed: () async {
              await controller.getCategories();
              controller.populateCategoryList();
              Get.to(const AddProducts());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: products, color: fontGrey, size: 16.0),
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
              return Center(
                child: CircularProgressIndicator(color: purpleColor),
              );
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: List.generate(
                    data.length,
                    (index) => Card(
                          child: ListTile(
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
                                text: '${data[index]['p_name']}',
                                color: fontGrey),
                            subtitle: Row(
                              children: [
                                normalText(
                                  text: '\$${data[index]['p_price']}',
                                  color: darkGrey,
                                ),
                                10.widthBox,
                                boldText(
                                  text: data[index]['is_featured'] == true
                                      ? 'Featured'
                                      : '',
                                  color: green,
                                )
                              ],
                            ),
                            trailing: VxPopupMenu(
                              menuBuilder: () {
                                return Column(
                                  children: List.generate(
                                      popupMenuTitle.length,
                                      (i) => Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  popupMenuIcon[i],
                                                  color:
                                                      data[index]['featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? green
                                                          : darkGrey,
                                                ),
                                                10.widthBox,
                                                normalText(
                                                    text:
                                                        data[index]['featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? 'Remove featured'
                                                            : popupMenuTitle[i],
                                                    color: darkGrey,
                                                    size: 14.0)
                                              ],
                                            ).onTap(() {
                                              switch (i) {
                                                case 0:
                                                  if (data[index]
                                                          ['is_featured'] ==
                                                      true) {
                                                    controller.removeFeatured(
                                                        data[index].id);

                                                    VxToast.show(context,
                                                        msg: 'Remove');
                                                  } else {
                                                    controller.addFeatured(
                                                        data[index].id);
                                                    VxToast.show(context,
                                                        msg: 'Add');
                                                  }
                                                  break;

                                                case 1:
                                                  break;
                                                case 2:
                                                  controller.removeProducts(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: 'Remove Products');
                                                  break;
                                              }
                                            }),
                                          )),
                                ).box.width(200).rounded.white.make();
                              },
                              clickType: VxClickType.singleClick,
                              child: const Icon(Icons.more_vert_rounded),
                            ),
                          ),
                        )),
              );
            }
          },
        ));
  }
}
