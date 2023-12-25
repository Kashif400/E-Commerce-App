import 'package:e_commerce_seller/components/round_button.dart';
import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intel;

import '../../components/order_placed_detail.dart';

class OrderDetail extends StatefulWidget {
  final dynamic data;
  const OrderDetail({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var controller = Get.put(OrderController());
  @override
  void initState() {
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivered.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: white,
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: RoundButton(
              title: 'Confirm Order',
              onTap: () {
                controller.confirmed(true);
                controller.changeStatus(
                    title: 'order_confirmed',
                    status: true,
                    docID: widget.data.id);
              },
              btnColor: green,
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: 'Order Details', color: fontGrey, size: 16.0),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              //order delivery status section
              Visibility(
                visible: controller.confirmed.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(
                        text: 'Order Status :', color: fontGrey, size: 16.0),
                    SwitchListTile(
                      activeColor: green,
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: 'Placed', color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: controller.confirmed.value,
                      onChanged: (value) {
                        controller.confirmed.value = value;
                        controller.changeStatus(
                            title: 'order_confirmed',
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: 'Confirmed', color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: controller.ondelivered.value,
                      onChanged: (value) {
                        controller.ondelivered.value = value;
                        controller.changeStatus(
                            title: 'order_on_deliver',
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: 'On Delivery ', color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: controller.delivered.value,
                      onChanged: (value) {
                        controller.delivered.value = value;
                        controller.changeStatus(
                            title: 'order_delivered',
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: 'Delivered', color: fontGrey),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .color(white)
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),

              //order detail section
              Column(
                children: [
                  orderPlacedDetaileWidget(
                      title1: 'Order Code',
                      title2: 'Shipping Method',
                      d1: '${widget.data['order_code']}',
                      d2: "${widget.data['shipping_method']}"),
                  orderPlacedDetaileWidget(
                      title1: 'Order Date',
                      title2: 'Payment Method',
                      // d1: DateTime.now(),
                      d1: intel.DateFormat()
                          .add_yMd()
                          .format(widget.data['order_date'].toDate()),
                      d2: '${widget.data['payment_method']}'),
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
                            boldText(
                              text: 'Shipping Adress',
                              color: purpleColor,
                            ),
                            "${widget.data['order_by_name']}".text.make(),
                            "${widget.data['order_by_email']}".text.make(),
                            "${widget.data['order_by_address']}".text.make(),
                            "${widget.data['order_by_city']}".text.make(),
                            "${widget.data['order_by_state']}".text.make(),
                            "${widget.data['order_by_phone']}".text.make(),
                            "${widget.data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: 'Total Amount', color: purpleColor),
                              boldText(
                                  text: '${widget.data['total_amount']}',
                                  color: red)
                              // 'Total Amount'.text.fontFamily(semibold).make(),
                              // '${data['total_amount']}'
                              //     .text
                              //     .color(redColor)
                              //     .fontFamily(bold)
                              //     .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
                  .box
                  .outerShadowMd
                  .color(white)
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered Product", color: fontGrey, size: 16.0),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(controller.orders.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlacedDetaileWidget(
                          title1: "${controller.orders[index]['title']}",
                          title2: "${controller.orders[index]['tprice']}",
                          d1: "${controller.orders[index]['qty']}x",
                          d2: 'Refundable'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 15,
                          color: Color(controller.orders[index]['color']),
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
      ),
    );
  }
}
