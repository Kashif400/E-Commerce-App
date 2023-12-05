import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/message_buble.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/controller/chat_controller.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var controller = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    print('hhhhhhhhhhhhhhhhhhhh>>>>>>>>>>>>>>');
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: '${controller.friendName}'
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirestoreServices.getChatMessage(
                          controller.chatDocId),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('Some Error');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('Welcome'),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final userData = snapshot.data!.docs[index];

                              return Align(
                                  alignment: userData['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: messageBuble(userData));
                            },
                          );
                        } else {
                          return const Text('No users');
                        }
                      },
                    ),
                  ),
          ),
          // Expanded(
          //   child: StreamBuilder(
          //     stream: FirestoreServices.getChatMessage(
          //         controller.chatDocId.value.toString()),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       } else if (snapshot.data!.docs.isEmpty) {
          //         return Center(
          //           child: 'hi'.text.color(darkFontGrey).make(),
          //         );
          //       } else {
          //         return ListView(
          //           reverse: true,
          //           children:
          //               snapshot.data!.docs.mapIndexed((currentValue, index) {
          //             var data = snapshot.data!.docs[index];
          //             return messageBuble(data);
          //           }).toList(),
          //         );
          //       }
          //     },
          //   ),
          // ),
          10.heightBox,
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: controller.msgController,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey))),
              )),
              IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ))
            ],
          )
              .box
              .height(70)
              .padding(const EdgeInsets.all(12))
              .margin(const EdgeInsets.only(bottom: 8))
              .make()
        ]),
      ),
    );
  }
}
