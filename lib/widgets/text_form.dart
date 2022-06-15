import 'package:bookstore/util/app_color.dart';
import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String hintText;
  final Icon icon;
 
  
  TextForm({
    required this.hintText,
    required this.icon,
    
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, ),
        hintText: hintText,
        prefixIcon: icon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: AppColor.pColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: AppColor.sColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
