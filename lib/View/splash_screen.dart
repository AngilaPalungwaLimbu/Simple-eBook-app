import 'package:bookstore/View/home_page.dart';
import 'package:bookstore/View/sign_in.dart';
import 'package:bookstore/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkauth() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var id=preferences.getString("id");
    if(id!=null){
      Future.delayed(Duration(seconds: 5), () {
      Get.off(() => HomeView());
    });
    }
    else{
      Future.delayed(Duration(seconds: 5), () {
      Get.off(() => SignInView());
    });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkauth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColor.pColor,
          child: Stack(
            children: [
              Center(
                child: Lottie.asset('images/book.json'),
              ),
              const Positioned(
                  top: 420,
                  left: 87,
                  child: Text(
                    'My Bookstore',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
