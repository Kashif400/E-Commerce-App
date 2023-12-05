import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebase_const.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController().obs;
  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
    print('###################');
    print(username);
  }
}
