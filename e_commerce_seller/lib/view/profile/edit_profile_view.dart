import 'dart:io';

import 'package:e_commerce_seller/components/custom_textfield.dart';
import 'package:e_commerce_seller/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';

class EditProfileView extends StatefulWidget {
  final String? username;
  const EditProfileView({super.key, this.username});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  var controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value
                ? CircularProgressIndicator(color: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                        controller.updateProfile(
                            imageUrl: controller.profileImageLink.value,
                            passowrd: controller.snapshotData['password'],
                            name: controller.snapshotData['vendor_name']);
                      } else {
                        controller.profileImageLink.value =
                            controller.snapshotData['imgUrl'];
                      }

                      //if old password matches database
                      if (controller.snapshotData['password'] ==
                          controller.oldPasswordController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password:
                                controller.oldPasswordController.text.trim(),
                            newPassword:
                                controller.newPasswordController.text.trim());

                        await controller.updateProfile(
                            name: controller.nameController.text,
                            passowrd: controller.newPasswordController.text,
                            imageUrl: controller.profileImageLink.value);
                        VxToast.show(context, msg: 'Update');
                      } else if (controller
                              .oldPasswordController.text.isEmptyOrNull &&
                          controller.newPasswordController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imageUrl: controller.profileImageLink,
                            name: controller.nameController.text.trim(),
                            passowrd: controller.snapshotData['password']);
                        VxToast.show(context, msg: 'Update');
                      } else {
                        VxToast.show(context, msg: 'Wrong old password');
                        controller.isLoading(false);
                      }
                    },
                    child: normalText(text: 'Save'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //if data image url and profileController is empty
              controller.snapshotData['imgUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50.0,
                      ),
                    )
                  : controller.snapshotData['imgUrl'] !=
                              '' && //if data image url is not empty and profilecontroller is empty
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imgUrl'],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              // Image.asset(
              //   imgProduct,
              //   width: 150,
              // ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              MaterialButton(
                color: white,
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),
              10.heightBox,
              customTextfield(
                  label: name,
                  hint: nameHint,
                  controller: controller.nameController),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: 'Change your Password')),
              10.heightBox,
              customTextfield(
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldPasswordController),
              10.heightBox,
              customTextfield(
                  label: 'Confirm password',
                  hint: 'confirm password',
                  controller: controller.newPasswordController)
            ],
          ),
        ),
      ),
    );
  }
}
