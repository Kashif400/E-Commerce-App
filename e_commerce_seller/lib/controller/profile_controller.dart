import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/view/profile/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

import '../const/firestore_const.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImagePath = ''.obs;
  //textfield controller
  var nameController = TextEditingController();
  var newPasswordController = TextEditingController();
  var oldPasswordController = TextEditingController();

  //shop controller
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();
  var profileImageLink = ''.obs;
  RxBool isLoading = false.obs;
  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      } else {
        profileImagePath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //upload image in firebase
  uploadProfileImage() async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(profileImagePath.value));
    profileImageLink.value = await reference.getDownloadURL();
  }

  //update profile
  updateProfile({name, passowrd, imageUrl}) async {
    isLoading(true);
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    await store.set(
        {'vendor_name': name, 'password': passowrd, 'imgUrl': imageUrl},
        SetOptions(merge: true)).then((value) {
      Get.off(ProfileView());
      isLoading(false);
    });
    isLoading(false);
  }

  //change password in firebase
  changeAuthPassword({email, password, newPassword}) async {
    isLoading(true);
    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(credential).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
      isLoading(false);
    });
    isLoading(false);
  }

  //update shop
  updateShop(
      {shopname, shopaddress, shopmobile, shopwebsite, shopdescription}) async {
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    await store.set({
      'shop_name': shopname,
      'shop_mobile': shopmobile,
      'shop_website': shopwebsite,
      'shop_address': shopaddress,
      'shop_description': shopdescription
    }, SetOptions(merge: true));
    isLoading(false);
  }
}
