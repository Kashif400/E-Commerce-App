import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var subcat = [].obs;
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubCategories({title}) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  //change color index
  changeColorIndex(index) {
    colorIndex.value = index;
  }

  //products increaments
  incQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  //products Decreaments
  decQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  //calculation total prices
  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  //add to cart data
  addToCart(
      {title, image, sellername, color, qty, tprice, vendorId, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': image,
      'sellername': sellername,
      'vendor_id': vendorId,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((e) {
      VxToast.show(context, msg: e);
    });
  }

  restValue() {
    totalPrice.value = 0;
    colorIndex.value = 0;
    quantity.value = 0;
  }

  //add wishlist
  addToWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);

    VxToast.show(context, msg: 'Add to wishlist');
  }

  //remove wishlist
  removeFromWishlist(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(
      context,
      msg: 'Remove from wishlist',
    );
  }

  checkIfFav(data) {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
    ;
  }
}
