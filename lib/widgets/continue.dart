import 'package:flutter/material.dart';

class ContinueWith extends StatelessWidget {
  final String logo;
  const ContinueWith({
    required this.logo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 57,
      child: MaterialButton(onPressed: (){},child: Image.asset(logo),)
    );
  }
}