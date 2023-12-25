import 'package:e_commerce_seller/const/firestore_const.dart';

class FirestoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get messages
  static getMessages(uid) {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  //get order
  static getOrder(uid) {
    return firestore
        .collection(orderCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  //get products
  static getProducts(uid) {
    return firestore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore
  //       .collection(productCollection)
  //       .where('vendor_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
