import 'package:bookstore/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final Function() onPressed;
   MyButton({
     required this.btnText,
     required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)),
      height: Get.size.height*0.07,
      elevation: 4,
      minWidth: MediaQuery.of(context).size.width,
      onPressed:onPressed,
      color: AppColor.pColor,
      child: Text(
        btnText,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
