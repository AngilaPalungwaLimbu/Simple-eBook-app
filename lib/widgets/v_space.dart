import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VSpace extends StatelessWidget {
  const VSpace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Get.size.height*0.02,);
  }
}
