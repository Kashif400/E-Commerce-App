import 'package:e_commerce_app/component/order_placed_detail.dart';
import 'package:e_commerce_app/component/order_status_widget.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intel;

class OrderDetail extends StatelessWidget {
  final dynamic data;
  const OrderDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Order Details'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            orderStatusWidget(
                context: context,
                color: redColor,
                icon: Icons.done,
                title: 'Order placed',
                showDone: data['order_place']),
            orderStatusWidget(
                context: context,
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: 'Confirm',
                showDone: data['order_confirmed']),
            orderStatusWidget(
                context: context,
                color: Colors.yellow,
                icon: Icons.car_crash_sharp,
                title: 'On Delivery',
                showDone: data['order_on_delivery']),
            orderStatusWidget(
                context: context,
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: 'On Delivered',
                showDone: data['order_delivered']),
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlacedDetaileWidget(
                    title1: 'Order Code',
                    title2: 'Shipping Method',
                    d1: data['order_code'],
                    d2: data['shipping_method']),
                orderPlacedDetaileWidget(
                    title1: 'Order Date',
                    title2: 'Payment Method',
                    d1: intel.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    d2: data['payment_method']),
                orderPlacedDetaileWidget(
                    title1: 'Payment Status',
                    title2: 'Delivery Status',
                    d1: 'Unpaid',
                    d2: 'Order Placed'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'Shipping Adress'.text.fontFamily(semibold).make(),
                          '${data['order_by_name']}'.text.make(),
                          '${data['order_by_email']}'.text.make(),
                          '${data['order_by_address']}'.text.make(),
                          '${data['order_by_city']}'.text.make(),
                          '${data['order_by_state']}'.text.make(),
                          '${data['order_by_phone']}'.text.make(),
                          '${data['order_by_postalcode']}'.text.make(),
                          // '${data['order_by_']}'.text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Total Amount'.text.fontFamily(semibold).make(),
                            '${data['total_amount']}'
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .make(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.color(whiteColor).make(),
            const Divider(),
            10.heightBox,
            "Ordered Product"
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedDetaileWidget(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: '${data['orders'][index]['qty']}x',
                        d2: 'Refundable'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 15,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    const Divider()
                  ],
                );
              }).toList(),
            )
                .box
                .outerShadowMd
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
            20.heightBox,
          ]),
        ),
      ),
    );
  }
}
