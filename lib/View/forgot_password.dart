import 'package:bookstore/util/app_color.dart';
import 'package:bookstore/widgets/my_button.dart';
import 'package:bookstore/widgets/text_form.dart';
import 'package:bookstore/widgets/v_space.dart';
import 'package:flutter/material.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 120,),
            Text('Forgot Password',style: TextStyle(fontSize: 25),),
            SizedBox(height: 20,),
            Text('Enter your email for the verification process. We will send you 4 digit code to your email',style: TextStyle(fontSize: 15,color: AppColor.sColor),),
            SizedBox(height: 25,),
            TextForm(hintText: 'Email', icon: Icon(Icons.email)),
            VSpace(),
          MyButton(btnText: 'Continue', onPressed: (){})

            
          ],
        ),
      ),
    );
  }
}