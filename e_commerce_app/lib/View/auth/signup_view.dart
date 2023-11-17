import 'package:e_commerce_app/View/auth/login_view.dart';
import 'package:e_commerce_app/component/applogo_widget.dart';
import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../component/custom_textfield.dart';
import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';

class SignupView extends StatefulWidget {
  const SignupView({
    super.key,
  });

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool? isCheck = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return bgWidght(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: w * .2,
            ),
            AppLogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Join the $appname',
              style: TextStyle(
                  color: Colors.white, fontFamily: bold, fontSize: 18),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: w * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 2.0), // Changes the shadow position
                    blurRadius: 5.0, // Changes the spread of the shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  customTextField(title: name, hint: name),
                  customTextField(title: email, hint: emailHint),
                  customTextField(title: password, hint: passwordHint),
                  customTextField(title: retypePassword, hint: retypePassword),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          forgetPassword,
                          style: TextStyle(color: Colors.blueAccent),
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: whiteColor,
                          activeColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(
                                text: "I agree to the",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey),
                                children: [
                              TextSpan(
                                text: termAndCondition,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor),
                              ),
                              TextSpan(
                                text: "&",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor),
                              ),
                            ])),
                      ),
                    ],
                  ),
                  RoundButton(
                    btnColor: isCheck == true ? redColor : lightGrey,
                    title: singUp,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: alreadHaveAccount,
                            style: TextStyle(fontFamily: bold, color: fontGrey),
                            children: [
                          TextSpan(
                            text: login,
                            style: TextStyle(fontFamily: bold, color: redColor),
                          ),
                        ])),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
