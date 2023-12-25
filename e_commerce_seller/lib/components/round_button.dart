import 'package:e_commerce_seller/const/colors.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  Color? btnColor;
  Color? textColor;
  RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.btnColor,
      this.textColor,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: btnColor ?? purpleColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(color: textColor ?? Colors.white),
                ),
        ),
      ),
    );
  }
}
