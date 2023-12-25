import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/const/images.dart';
import 'package:e_commerce_seller/const/strings.dart';
import 'package:e_commerce_seller/controller/home_controller.dart';
import 'package:e_commerce_seller/view/home/home_view.dart';
import 'package:e_commerce_seller/view/order/order_view.dart';
import 'package:e_commerce_seller/view/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile/profile_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeView(),
      const ProductsView(),
      const OrderView(),
      const ProfileView()
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: dashboard,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, color: darkGrey, width: 24),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, color: darkGrey, width: 24),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, color: darkGrey, width: 24),
          label: settings)
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
