import 'package:bookstore/View/home_page.dart';
import 'package:bookstore/View/pages/homepage.dart';
import 'package:bookstore/View/sign_in.dart';
import 'package:bookstore/View/splash_screen.dart';
import 'package:bookstore/bindings/controller_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Bookstore',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      initialBinding: ControllerBinding(),
      home: SplashScreen(),
    );
  }
}

