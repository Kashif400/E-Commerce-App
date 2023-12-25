import 'package:e_commerce_app/View/auth/signup_view.dart';
import 'package:e_commerce_app/View/home/home.dart';
import 'package:e_commerce_app/component/applogo_widget.dart';
import 'package:e_commerce_app/component/bgWidget.dart';
import 'package:e_commerce_app/component/round_button.dart';
import 'package:e_commerce_app/consts/images.dart';
import 'package:e_commerce_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../component/custom_textfield.dart';
import '../../consts/colors.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    var authController = Get.put(AuthController());

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
              'Login in to $appname',
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
                      title: email,
                      hint: emailHint,
                      controller: emailC,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordC,
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
                  Obx(
                    () => RoundButton(
                      loading: authController.loading.value,
                      title: login,
                      onTap: () async {
                        if (emailC.text.isEmpty && passwordC.text.isEmpty) {
                          VxToast.show(context,
                              msg: 'Please fill',
                              textColor: whiteColor,
                              bgColor: redColor,
                              showTime: 4000);
                        } else {
                          authController.loginMethod(
                              context: context,
                              email: emailC.text.trim(),
                              password: passwordC.text.trim());
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(createNewAccount),
                  const SizedBox(
                    height: 5,
                  ),
                  RoundButton(
                      textColor: redColor,
                      btnColor: lightGolden,
                      title: singUp,
                      onTap: () {
                        Get.to(SignupView());
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(loginWith),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Image.asset(icFacebookLogo),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        child: Image.asset(icGoogleLogo),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        child: Image.asset(
                          icTwitterLogo,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
