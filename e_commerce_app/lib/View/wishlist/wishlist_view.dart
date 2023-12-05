import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            'My Wishlist'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Expanded(
        child: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return 'No wishlist yet!'.text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      '${data[index]['p_images'][0]}',
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: '${data[index]['p_name']}'
                        .text
                        .fontFamily(semibold)
                        .size(16)
                        .make(),
                    subtitle: '${data[index]['p_price']}'
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(
                      Icons.favorite,
                      color: redColor,
                    ).onTap(() async {
                      await firestore
                          .collection(productCollection)
                          .doc(data[index].id)
                          .set({
                        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    }),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
