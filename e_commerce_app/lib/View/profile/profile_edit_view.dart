import 'dart:io';

import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/component/custom_textfield.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/images.dart';
import '../../consts/strings.dart';

class ProfileEditView extends StatelessWidget {
  final dynamic data;
  const ProfileEditView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    profileController.nameController.text = data['name'];
    return bgWidght(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url and profileController is empty
              data['imageUrl'] == '' &&
                      profileController.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] !=
                              '' && //if data image url is not empty and profilecontroller is empty
                          profileController.profileImagePath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(profileController.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              //button
              SizedBox(
                width: 100,
                child: RoundButton(
                  title: 'Change',
                  onTap: () {
                    profileController.changeImage(context);
                  },
                ),
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                  title: name,
                  hint: name,
                  isPass: false,
                  controller: profileController.nameController),
              10.heightBox,
              customTextField(
                  title: 'old password',
                  hint: passwordHint,
                  isPass: true,
                  controller: profileController.oldPasswordController),

              10.heightBox,
              customTextField(
                  title: 'new password',
                  hint: 'enter new password',
                  isPass: true,
                  controller: profileController.newPasswordController),

              20.heightBox,
              RoundButton(
                  loading: profileController.isLoading.value,
                  title: 'Save',
                  onTap: () async {
                    profileController.isLoading(true);

                    //if image is not selected
                    if (profileController.profileImagePath.value.isNotEmpty) {
                      await profileController.uploadProfileImage();
                    } else {
                      profileController.profileImageLink.value =
                          data['imageUrl'];
                    }

                    //if old password matches database
                    if (data['password'] ==
                        profileController.oldPasswordController.text) {
                      await profileController.changeAuthPassword(
                          email: data['email'],
                          password: profileController.oldPasswordController.text
                              .trim(),
                          newPassword: profileController
                              .newPasswordController.text
                              .trim());

                      await profileController.updateProfile(
                          name: profileController.nameController.text,
                          passowrd:
                              profileController.newPasswordController.text,
                          imageUrl: profileController.profileImageLink.value);
                      VxToast.show(context, msg: 'Update');
                    } else {
                      VxToast.show(context, msg: 'Wrong old password');
                      profileController.isLoading(false);
                    }
                  })
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .rounded
              .make(),
        ),
      ),
    ));
  }
}
