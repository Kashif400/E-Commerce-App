// // class ChatController extends GetxController {
// //   @override
// //   void onInit() {
// //     getChatId();
// //     super.onInit();
// //   }

// //   var chats = firestore.collection(chatsCollection);

// //   var friendName = Get.arguments[0];
// //   var friendId = Get.arguments[1];

// //   var senderName = Get.find<HomeController>().username;
// //   var currentId = auth.currentUser!.uid;
// //   var msgController = TextEditingController();
// //   dynamic chatDocId;
// //   getChatId() async {
// //     await chats
// //         .where('users', isEqualTo: {
// //           friendId = null,
// //           currentId = null,
// //         })
// //         .limit(1)
// //         .get()
// //         .then((QuerySnapshot snapshot) {
// //           if (snapshot.docs.isNotEmpty) {
// //             chatDocId = snapshot.docs.single.id;
// //           } else {
// //             chats.add({
// //               'created_on': null,
// //               'last_msg': '',
// //               'users': {friendId: null, currentId: null},
// //               'toId': '',
// //               'fromId': '',
// //               'friend_name': friendName,
// //               'sender_name': senderName,
// //             }).then((value) {
// //               chatDocId = value.id;
// //             });
// //           }
// //         });
// //   }

// //   sendMsg({String? msg}) {
// //     if (msg!.trim().isNotEmpty) {
// //       chats.doc(chatDocId).update({
// //         'created_on': FieldValue.serverTimestamp(),
// //         'last_msg': msg,
// //         'toId': friendId,
// //         'fromId': currentId,
// //       });
// //       chats.doc(chatDocId).collection(messagesCollection).doc().set({
// //         'created_on': FieldValue.serverTimestamp(),
// //         'msg': msg,
// //         'uid': currentId
// //       });
// //     }
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_app/consts/firebase_const.dart';
// import 'package:e_commerce_app/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // class ChatController extends GetxController {
// //   @override
// //   void onInit() {
// //     getChatId();

// //     print('xxxxxxxxxxxxxxxxxx');
// //     print('currentId : $currentId');

// //     print('xxxxxxxxxxxxxxxxxx');
// //     print('FriendId : $friendId');
// //     print('xxxxxxxxxxxxxxxxxx');
// //     super.onInit();
// //   }

// //   var friendName = Get.arguments[0];
// //   var friendId = Get.arguments[1];

// //   var senderName = Get.find<HomeController>().username;
// //   var currentId = auth.currentUser!.uid;
// //   var msgController = TextEditingController();
// //   dynamic chatDocId;

// //   getChatId() async {
// //     await firestore
// //         .collection(chatsCollection)
// //         .where('users', isEqualTo: {friendId: null, currentId: null})
// //         .limit(1)
// //         .get()
// //         .then((QuerySnapshot snapshot) async {
// //           if (snapshot.docs.isNotEmpty) {
// //             chatDocId = snapshot.docs.single.id;
// //           } else {
// //             firestore.collection(chatsCollection).add({
// //               'created_on': null,
// //               'last_msg': '',
// //               'users': {friendId: null, currentId: null},
// //               'toId': '',
// //               'fromId': '',
// //               'friend_name': friendName,
// //               'sender_name': senderName,
// //             }).then((value) {
// //               chatDocId = value.id;
// //             });
// //           }
// //         });
// //   }

// //   sendMsg({String? msg}) {
// //     if (msg!.trim().isNotEmpty) {
// //       firestore.collection(chatsCollection).doc(chatDocId).update({
// //         'created_on': FieldValue.serverTimestamp(),
// //         'last_msg': msg,
// //         'toId': friendId,
// //         'fromId': currentId,
// //       });
// //       firestore
// //           .collection(chatsCollection)
// //           .doc(chatDocId)
// //           .collection(messagesCollection)
// //           .doc()
// //           .set({
// //         'created_on': FieldValue.serverTimestamp(),
// //         'msg': msg,
// //         'uid': currentId,
// //       });
// //     }
// //   }
// // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/firebase_const.dart';
import 'home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var isLoading = false.obs;
  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.put(HomeController()).username;
  var currentId = auth.currentUser!.uid;

  var msgController = TextEditingController();
  dynamic chatDocId;
  getChatId() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toId': '',
              'from_Id': '',
              'friend_name': friendName,
              'sender_name': senderName
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) {
    isLoading(true);
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
      isLoading(false);
    }
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_commerce_app/consts/firebase_const.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';

// import 'home_controller.dart';

// class ChatContoller extends GetxController {
//   // get instances of auth and firestore
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   var friendName = Get.arguments[0];
//   var friendId = Get.arguments[1];

//   var senderName = Get.find<HomeController>().username;
//   var currentId = auth.currentUser!.uid;
//   var msgController = TextEditingController();
//   dynamic chatDocId;
//   // send message
//   Future<void> sendMessage({
//     required String message,
//     final String? pushNotification,
//   }) async {
//     // get current user info

//     final currentUserId = _auth.currentUser!.uid;
//     final String currentUserEmail = _auth.currentUser!.email.toString();
//     final Timestamp timestamp = Timestamp.now();
//     //construct chat room id from current user id and receiver id (sorted to ensure uniqueness)

//     List<String> ids = [currentUserId, friendId];
//     ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair of people)
//     String chatRoomId = ids.join(
//         '_'); // combaine the ids into a single string to use as a chatroomId

//     // add new message to database
//     await firestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .add({
//       'last_message': message,
//       'message': message,
//       'senderId': currentUserId,
//       'senderEmail': currentUserEmail,
//       'receiverId': friendId,
//       'receiverName': friendName,
//       'timestamp': timestamp
//     }).then((value) {
//       // notificationServices.sendPushNotification(message, pushNotification!,
//       //     _auth.currentUser!.displayName.toString());
//     });
//   }

//   //get messages
//   Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
//     // construct chatroom id from user id(sorted to ensure it matches the id used when sending messages)
//     List<String> ids = [userId, otherUserId];
//     ids.sort();
//     String chatRoomId = ids.join('_');
//     return firestore
//         .collection('chat_rooms')
//         .doc(chatRoomId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }

//   Stream<QuerySnapshot> getAllMessages() {
//     return firestore.collection('chat_rooms').snapshots();
//   }
// }
