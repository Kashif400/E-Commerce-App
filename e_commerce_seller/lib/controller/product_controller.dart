import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/controller/home_controller.dart';
import 'package:e_commerce_seller/models/category_model.dart';
import 'package:e_commerce_seller/view/home/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

import '../const/firestore_const.dart';

class ProductController extends GetxController {
  var isloading = false.obs;
  var pnameController = TextEditingController();
  var pdesController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesLinks = [].obs;
  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategoryList(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (image == null) {
        return;
      } else {
        pImagesList[index] = File(image.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference reference = FirebaseStorage.instance.ref().child(destination);
        await reference.putFile(item);
        var n = await reference.getDownloadURL();

        pImagesLinks.add(n);
      }
    }
  }

  //upload products
  uploadProducts(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'featured_id': '',
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_colors': FieldValue.arrayUnion(
          [Colors.red.value, Colors.black.value, Colors.amber.value]),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_name': pnameController.text,
      'p_description': pdesController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_rating': '5.0',
      'p_seller': Get.put(HomeController()).username,
      'vendor_id': currentUser!.uid
    });
    isloading(false);
    VxToast.show(context, msg: 'Products uploaded');
  }

  // add featured
  addFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': currentUser!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removeFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': '', 'is_featured': false}, SetOptions(merge: true));
  }

  removeProducts(docID) async {
    await firestore.collection(productCollection).doc(docID).delete();
  }
}
