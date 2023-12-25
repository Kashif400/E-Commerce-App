import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orders = [].obs;
  var confirmed = false.obs;
  var ondelivered = false.obs;
  var delivered = false.obs;
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  //status change
  changeStatus({title, status, docID}) async {
    var store = firestore.collection(orderCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
