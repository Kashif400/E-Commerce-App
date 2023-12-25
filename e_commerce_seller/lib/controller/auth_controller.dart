import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/view/auth/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/firestore_const.dart';
import '../view/home/home.dart';

class AuthController extends GetxController {
  //loding var
  RxBool loading = false.obs;

  //login method
  Future<UserCredential?> loginMethod({email, password, context}) async {
    loading.value = true;
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      loading.value = false;
      VxToast.show(context,
          msg: 'Login', textColor: white, bgColor: red, showTime: 4000);
      Get.offAll(const Home());
    }).onError((error, stackTrace) {
      loading.value = false;
      VxToast.show(context,
          msg: error.toString(),
          textColor: white,
          bgColor: red,
          showTime: 4000);
    });
  }

  //sign out method
  signoutMethod({context}) async {
    try {
      await auth.signOut().then((value) {
        Get.to(const LoginView());
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
