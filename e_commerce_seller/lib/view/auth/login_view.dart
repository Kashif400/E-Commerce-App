import 'package:e_commerce_seller/components/round_button.dart';
import 'package:e_commerce_seller/components/text_style.dart';
import 'package:e_commerce_seller/const/colors.dart';
import 'package:e_commerce_seller/const/images.dart';
import 'package:e_commerce_seller/const/strings.dart';
import 'package:e_commerce_seller/controller/auth_controller.dart';
import 'package:e_commerce_seller/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    final authController = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            normalText(text: welcome, size: 18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .border(color: white)
                    .rounded
                    .padding(const EdgeInsets.all(8.0))
                    .make(),
                10.widthBox,
                boldText(text: appname, size: 20.0)
              ],
            ),
            40.heightBox,
            normalText(text: loginTo, size: 18.0, color: lightGrey),
            10.heightBox,
            Column(
              children: [
                5.heightBox,
                TextFormField(
                  controller: emailC,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: purpleColor,
                    ),
                    border: InputBorder.none,
                    hintText: emailHint,
                    filled: true,
                    fillColor: lightGrey,
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor)),
                  ),
                ),
                10.heightBox,
                TextFormField(
                  controller: passwordC,
                  decoration: const InputDecoration(
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor)),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: purpleColor,
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: lightGrey,
                    hintText: passwordHint,
                  ),
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: normalText(
                          text: forgotPassword,
                          color: purpleColor,
                          size: 14.0)),
                ),
                15.heightBox,
                Obx(
                  () => SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: RoundButton(
                          loading: authController.loading.value,
                          title: 'login',
                          onTap: () async {
                            if (emailC.text.isEmpty && passwordC.text.isEmpty) {
                              VxToast.show(context,
                                  msg: 'Please fill',
                                  textColor: white,
                                  bgColor: red,
                                  showTime: 4000);
                            } else {
                              authController.loginMethod(
                                  context: context,
                                  email: emailC.text.trim(),
                                  password: passwordC.text.trim());
                            }
                          })),
                )
              ],
            )
                .box
                .white
                .rounded
                .outerShadowMd
                .padding(const EdgeInsets.all(8.0))
                .make(),
            10.heightBox,
            Center(
              child: normalText(text: anyProblem, size: 13.0, color: lightGrey),
            ),
            const Spacer(),
            Center(
              child: boldText(text: credit, size: 14.0),
            )
          ],
        ),
      )),
    );
  }
}
