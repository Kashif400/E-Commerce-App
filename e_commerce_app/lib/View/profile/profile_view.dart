import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/auth/login_view.dart';
import 'package:e_commerce_app/View/chat/message_user_view.dart';
import 'package:e_commerce_app/View/order/order_view.dart';
import 'package:e_commerce_app/View/profile/profile_edit_view.dart';
import 'package:e_commerce_app/View/wishlist/wishlist_view.dart';
import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/component/cart_detail_widget.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/list.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:e_commerce_app/controller/profile_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    return bgWidght(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: redColor),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
              child: Column(
            children: [
              //edit profile section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                  ),
                ).onTap(() {
                  Get.to(ProfileEditView(data: data));
                }),
              ),

              //user detail section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundColor: whiteColor,
                            child: Icon(Icons.person),
                          )
                        : Image.network(
                            data['imageUrl'],
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        5.heightBox,
                        "${data['email']}".text.white.make()
                      ],
                    )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor)),
                        onPressed: () async {
                          await Get.put(AuthController().signoutMethod());
                          Get.offAll(LoginView());
                        },
                        child: "Logout".text.fontFamily(semibold).white.make())
                  ],
                ),
              ),
              20.heightBox,
              FutureBuilder(
                future: FirestoreServices.getCounts(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print(snapshot.data);
                    var countData = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cartWidget(
                          count: countData[0].toString(),
                          title: "in your cart",
                          width: context.screenWidth / 3.4,
                        ),
                        cartWidget(
                          count: countData[1].toString(),
                          title: "in your wishList",
                          width: context.screenWidth / 3.4,
                        ),
                        cartWidget(
                          count: countData[2].toString(),
                          title: "in your order",
                          width: context.screenWidth / 3.4,
                        ),
                      ],
                    ).box.color(redColor).make();
                  }
                },
              ),
              //button section

              ListView.separated(
                      shrinkWrap: true,
                      itemCount: profileButtonList.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(const OrderView());
                                break;

                              case 1:
                                Get.to(const WishlistView());
                                break;

                              case 2:
                                Get.to(const MessageView());
                                break;
                            }
                          },
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          leading: Image.asset(
                            profileButtonIconList[index],
                            width: 22,
                          ),
                        );
                      })
                  .box
                  .white
                  .rounded
                  .margin(const EdgeInsets.all(12))
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .shadowSm
                  .make()
                  .box
                  .color(redColor)
                  .make()
            ],
          ));
        }
      },
    )));
  }
}
