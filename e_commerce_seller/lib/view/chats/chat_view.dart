import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_seller/const/firestore_const.dart';
import 'package:e_commerce_seller/services/firestore_services.dart';
import 'package:e_commerce_seller/view/chats/message_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';
import 'package:intl/intl.dart' as intel;

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        automaticallyImplyLeading: false,
        title: boldText(text: 'Chats', color: fontGrey, size: 16.0),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: purpleColor),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();
                    var time = intel.DateFormat('h:ma').format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(MessageView());
                      },
                      leading: const CircleAvatar(
                        backgroundColor: purpleColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                        ),
                      ),
                      title: boldText(
                          text: '${data[index]['sender_name']}',
                          color: fontGrey),
                      subtitle: normalText(
                          text: '${data[index]['last_msg']}', color: darkGrey),
                      trailing: normalText(text: time, color: darkGrey),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //           3,
      //           (index) => ListTile(
      //                 onTap: () {
      //                   Get.to(MessageView());
      //                 },
      //                 leading: const CircleAvatar(
      //                   backgroundColor: purpleColor,
      //                   child: Icon(
      //                     Icons.person,
      //                     color: white,
      //                   ),
      //                 ),
      //                 title: boldText(text: name, color: fontGrey),
      //                 subtitle:
      //                     normalText(text: 'last message...', color: darkGrey),
      //                 trailing: normalText(text: '10:15 pm', color: darkGrey),
      //               )),
      //     ),
      //   ),
      // ),
    );
  }
}
