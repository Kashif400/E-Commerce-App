import 'package:e_commerce_app/consts/colors.dart';
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
            color: btnColor ?? redColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
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
