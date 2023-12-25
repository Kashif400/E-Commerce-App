import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:e_commerce_seller/const/images.dart';
import 'package:e_commerce_seller/const/lists.dart';
import 'package:e_commerce_seller/const/strings.dart';
import 'package:e_commerce_seller/controller/auth_controller.dart';
import 'package:e_commerce_seller/controller/profile_controller.dart';
import 'package:e_commerce_seller/services/firestore_services.dart';
import 'package:e_commerce_seller/view/chats/chat_view.dart';
import 'package:e_commerce_seller/view/profile/edit_profile_view.dart';
import 'package:e_commerce_seller/view/shop_setting/shop_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(EditProfileView(
                    username: controller.snapshotData['vendor_name'],
                  ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: white,
                )),
            TextButton(
                onPressed: () {
                  Get.put(AuthController()).signoutMethod();
                },
                child: normalText(text: logout))
          ],
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProfile(auth.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: white,
              ));
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: controller.snapshotData['imgUrl'] == ''
                          ? const CircleAvatar(
                              radius: 40,
                              child: Icon(
                                Icons.person,
                                size: 40,
                              ),
                            )
                          : Image.network(
                              controller.snapshotData['imgUrl'],
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      title: boldText(
                          text: '${controller.snapshotData['vendor_name']}'),
                      subtitle: normalText(
                          text: '${controller.snapshotData['email']}'),
                    ),
                    const Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(
                            profileButtionTitle.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(const ShopSettingView());
                                        break;
                                      case 1:
                                        Get.to(const ChatView());
                                    }
                                  },
                                  leading: Icon(
                                    profileButtionIcon[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: profileButtionTitle[index]),
                                )),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
