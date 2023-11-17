import 'package:e_commerce_app/View/category/category_view.dart';
import 'package:e_commerce_app/View/profile/profile_view.dart';
import 'package:e_commerce_app/consts/colors.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/consts/strings.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../Cart/car_view.dart';
import 'home_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account),
    ];
    var navBody = [HomeView(), CategoryView(), CartView(), ProfileView()];
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: navbarItem,
          currentIndex: homeController.currentIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value) {
            homeController.currentIndex.value = value;
          },
        ),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(homeController.currentIndex.value)))
        ],
      ),
    );
  }
}
