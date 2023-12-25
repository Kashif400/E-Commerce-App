import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:e_commerce_seller/controller/order_controller.dart';
import 'package:e_commerce_seller/services/firestore_services.dart';
import 'package:e_commerce_seller/view/order/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/strings.dart';
import 'package:intl/intl.dart' as intel;

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: orders, color: fontGrey, size: 16.0),
        actions: [
          Center(
            child: normalText(
                text:
                    intel.DateFormat('EE, MMM d,' 'yy').format(DateTime.now()),
                color: purpleColor,
                size: 14.0),
          ),
          10.widthBox
        ],
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getOrder(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: purpleColor),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        Get.to(OrderDetail(
                          data: data[index],
                        ));
                      },
                      title: boldText(
                          text: '${data[index]['order_code']}',
                          color: purpleColor,
                          size: 16.0),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text:
                                      intel.DateFormat().add_yMd().format(time),
                                  color: fontGrey)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: 'Unpaid', color: red, size: 16.0)
                            ],
                          )
                          // boldText(text: '\$20', color: darkGrey),
                        ],
                      ),
                      trailing: boldText(
                          text: '${data[index]['total_amount']}',
                          size: 16.0,
                          color: purpleColor),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //           20,
      //           (index) => ListTile(
      //                 tileColor: textfieldGrey,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(12)),
      //                 onTap: () {
      //                   Get.to(OrderDetail());
      //                 },
      //                 title: boldText(
      //                     text: '9002342', color: purpleColor, size: 16.0),
      //                 subtitle: Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         const Icon(
      //                           Icons.calendar_month,
      //                           color: fontGrey,
      //                         ),
      //                         10.widthBox,
      //                         boldText(
      //                             text: intel.DateFormat()
      //                                 .add_yMd()
      //                                 .format(DateTime.now()),
      //                             color: fontGrey)
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //                         const Icon(
      //                           Icons.payment,
      //                           color: fontGrey,
      //                         ),
      //                         10.widthBox,
      //                         boldText(text: 'Unpaid', color: red, size: 16.0)
      //                       ],
      //                     )
      //                     // boldText(text: '\$20', color: darkGrey),
      //                   ],
      //                 ),
      //                 trailing: boldText(
      //                     text: '\$20.0', size: 16.0, color: purpleColor),
      //               ).box.margin(const EdgeInsets.only(bottom: 4)).make()),
      //     ),
      //   ),
      // ),
    );
  }
}
