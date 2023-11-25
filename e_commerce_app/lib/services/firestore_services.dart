import 'package:e_commerce_app/consts/firebase_const.dart';

class FirestoreServices {
  //get user data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get product data
  static getProducts({category}) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
}
