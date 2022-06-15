import 'package:bookstore/View/sign_in.dart';
import 'package:bookstore/util/app_color.dart';
import 'package:bookstore/widgets/my_button.dart';
import 'package:bookstore/widgets/text_form.dart';
import 'package:bookstore/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                SizedBox(height: Get.size.height*0.09,),
                Text('Register',style: TextStyle(fontSize:35,fontWeight: FontWeight.w500),),
                VSpace(),
                Text('Sign up to get started!',style:  TextStyle(fontSize: 17,color: Color.fromARGB(255, 131, 131, 131),),),
                VSpace(),
                VSpace(),
                TextForm(hintText: 'Username', icon: Icon(Icons.person)),
                VSpace(),
                TextForm(hintText: 'Email', icon: Icon(Icons.email)),
                VSpace(),
                TextForm(hintText: 'Password', icon: Icon(Icons.lock)),
                VSpace(),
                TextForm(hintText: 'Confirm Password', icon: Icon(Icons.lock)),
                VSpace(),
                MyButton(btnText: 'Sign Up', onPressed: (){Get.to(()=>SignInView());}),
                SizedBox(height: Get.size.height*0.16,),

                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',style: TextStyle(fontSize: 15),),
                  InkWell(
                    onTap: (){
                      Get.to(()=>SignInView());
                    },
                    child: Text(' Sign in',style: TextStyle(fontSize: 15,color: AppColor.pColor,fontWeight: FontWeight.bold),)),
                ],
              )
              ],
            ),
          ),
        )
      ),
    );
  }
}