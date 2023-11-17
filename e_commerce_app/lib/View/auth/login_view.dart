import 'package:e_commerce_app/View/auth/signup_view.dart';
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

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 2.0), // Changes the shadow position
                    blurRadius: 5.0, // Changes the spread of the shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  customTextField(title: email, hint: emailHint),
                  customTextField(title: password, hint: passwordHint),
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
                  RoundButton(
                    title: login,
                    onTap: () {},
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        child: Image.asset(icFacebookLogo),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        child: Image.asset(icGoogleLogo),
                      ),
                      SizedBox(
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
