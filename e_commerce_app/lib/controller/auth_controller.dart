import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/colors.dart';

class AuthController extends GetxController {
  //loding var
  RxBool loading = false.obs;

  //login method
  Future<UserCredential?> loginMethod({email, password, context}) async {
    loading.value = true;
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        loading.value = false;
        VxToast.show(context,
            msg: 'Login',
            textColor: whiteColor,
            bgColor: redColor,
            showTime: 4000);

        // Delay navigation
        // await Future.delayed(const Duration(milliseconds: 500), () {
        //   Get.offAll(const Home());
        // });
        Get.offAll(Home());
      },
    ).onError((error, stackTrace) {
      loading.value = false;
      VxToast.show(context,
          msg: error.toString(),
          textColor: whiteColor,
          bgColor: redColor,
          showTime: 4000);
    });
  }

  // signup method
  Future signupMethod({
    email,
    password,
    context,
    name,
  }) async {
    loading.value = true;
    await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) async {
        loading.value = false;
        //store data
        DocumentReference store = firestore
            .collection(userCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid);
        await store.set({
          'seller_type': false,
          'name': name,
          'password': password,
          'email': email,
          'imageUrl': '',
          'id': currentUser!.uid,
          'cart_count': '00',
          'wishlist_count': '00',
          'order_count': '00'
        }).then((value) async {
          loading.value = false;
          VxToast.show(context,
              msg: 'Create Successfully',
              textColor: whiteColor,
              bgColor: redColor,
              showTime: 4000);

          // Delay navigation
          // await Future.delayed(const Duration(milliseconds: 500), () {
          //   Get.offAll(const Home());
          // });
          Get.offAll(Home());
        });
      },
    ).onError((error, stackTrace) {
      loading.value = false;
      VxToast.show(context,
          msg: error.toString(),
          textColor: whiteColor,
          bgColor: redColor,
          showTime: 4000);
    });
  }

  //sign out method
  signoutMethod({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
