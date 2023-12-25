import 'package:e_commerce_seller/components/message_buble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/text_style.dart';
import '../../const/colors.dart';
import '../../const/strings.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

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
        title: boldText(text: 'Username', color: fontGrey, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => messageBuble())),
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: purpleColor,
                      ))
                ],
              ).box.padding(const EdgeInsets.all(12)).make(),
            )
          ],
        ),
      ),
    );
  }
}
