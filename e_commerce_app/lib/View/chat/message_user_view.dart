import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/View/chat/chat_view.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Message'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessage(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return 'No seller yet!'.text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Get.to(const ChatView(), arguments: [
                          data[index]['friend_name'],
                          data[index]['toId']
                        ]);
                      },
                      leading: const CircleAvatar(
                        backgroundColor: redColor,
                        child: Icon(
                          Icons.person,
                          color: whiteColor,
                        ),
                      ),
                      title: '${data[index]['friend_name']}'
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      subtitle: '${data[index]['last_msg']}'.text.make(),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
