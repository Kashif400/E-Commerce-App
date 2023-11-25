import 'package:e_commerce_app/View/auth/login_view.dart';
import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/component/applogo_widget.dart';
import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/firebase_const.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
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
  var authController = Get.put(AuthController());

  TextEditingController nameC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController passwordReTypeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return bgWidght(
        child: Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0.0, 2.0), // Changes the shadow position
                      blurRadius: 5.0, // Changes the spread of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    customTextField(
                        title: name,
                        hint: name,
                        controller: nameC,
                        isPass: false),
                    customTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailC,
                        isPass: false),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordC,
                        isPass: true),
                    customTextField(
                        title: retypePassword,
                        hint: retypePassword,
                        controller: passwordReTypeC,
                        isPass: true),
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
                    Obx(
                      () => RoundButton(
                        loading: authController.loading.value,
                        btnColor: isCheck == true ? redColor : lightGrey,
                        title: singUp,
                        onTap: () {
                          if (passwordC.text.trim() ==
                              passwordReTypeC.text.trim()) {
                            if (isCheck!) {
                              try {
                                authController.signupMethod(
                                    context: context,
                                    name: nameC.text.trim(),
                                    email: emailC.text.trim(),
                                    password: passwordC.text.trim());
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context,
                                    msg: e.toString(),
                                    textColor: whiteColor,
                                    bgColor: redColor,
                                    showTime: 4000);
                              }
                            }
                          } else {
                            VxToast.show(context,
                                msg: "please match password",
                                textColor: whiteColor,
                                bgColor: redColor,
                                showTime: 4000);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: RichText(
                          text: const TextSpan(
                              text: alreadHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey),
                              children: [
                            TextSpan(
                              text: login,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor),
                            ),
                          ])),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
