import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/Controller/product.dart';
import 'package:bookstore/View/forgot_password.dart';
import 'package:bookstore/View/home_page.dart';
import 'package:bookstore/View/sign_up.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:bookstore/util/app_color.dart';
import 'package:bookstore/widgets/continue.dart';
import 'package:bookstore/widgets/my_button.dart';
import 'package:bookstore/widgets/text_form.dart';
import 'package:bookstore/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> _key = GlobalKey<FormState>();
    var cc=Get.find<CartController>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _key,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset('images/book.json',
                      height: Get.size.height * 0.35),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      Get.off(()=>HomeView());
                    },
                    child: Text("Skip",style: TextStyle(fontSize: 16,color: AppColor.pColor,fontWeight: FontWeight.bold),))
                     
                ),
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: Get.size.height * 0.3,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (Value) => Value!.isEmpty ? "required" : null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: AppColor.pColor,
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: AppColor.pColor,
                            width: 1.5,
                          ),
                        ),
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
                    ),
                    VSpace(),
                    TextFormField(
                      controller: password,
                      validator: (Value) => Value!.isEmpty ? "required" : null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: AppColor.pColor,
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: AppColor.pColor,
                            width: 1.5,
                          ),
                        ),
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
                    ),
                    VSpace(),
                    Container(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Get.to(() => ForgotView());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: AppColor.pColor,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    VSpace(),
                    MyButton(
                      btnText: 'Sign In',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          RemoteService.login(email.text, password.text).whenComplete(()async{
                            SharedPreferences preferences=await SharedPreferences.getInstance();
                             var id=preferences.getString("id");
                             if(id!=null){
                               cc.getcartdetail(int.parse(id));
                             }
                          });
                        }
                      },
                    ),
                    VSpace(),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                        )),
                        Text(
                          ' Continue With ',
                          style: TextStyle(color: AppColor.sColor),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContinueWith(logo: 'images/google.png'),
                        ContinueWith(logo: 'images/apple.png'),
                        ContinueWith(logo: 'images/facebook.png'),
                      ],
                    ),
                    SizedBox(
                      height: Get.size.height * 0.12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => SignUpView());
                            },
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: AppColor.pColor),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
