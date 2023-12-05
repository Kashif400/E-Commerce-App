import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebase_const.dart';

class CartController extends GetxController {
  //shipping controller
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var totalPrice = 0.obs;
  var paymentIndex = 0.obs;
  var placeingOrder = false.obs;
  late dynamic productSnapshot;
  var product = [];
  calculate(data) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[i]['tprice'].toString());
    }
  }

  //change index payment
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  //order place
  placeMyOrder({required orderPaymentMthod, required totalAmount}) async {
    getProductDetails();
    placeingOrder(true);
    await firestore.collection(orderCollection).doc().set({
      'order_code': 2323323,
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text.trim(),
      'order_by_state': stateController.text.trim(),
      'order_by_city': cityController.text.trim(),
      'order_by_phone': phoneController.text.trim(),
      'order_by_postalcode': postalCodeController.text.trim(),
      'shipping_method': 'Home Delivery',
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'payment_method': orderPaymentMthod,
      'order_place': true,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(product)
    });
    placeingOrder(false);
  }

  getProductDetails() {
    product.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      product.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title']
      });
    }
  }

  //clear cart
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
