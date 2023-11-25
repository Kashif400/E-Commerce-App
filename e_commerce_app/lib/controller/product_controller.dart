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
  addToCart({title, image, sellername, color, qty, tprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': image,
      'sellername': sellername,
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
}
