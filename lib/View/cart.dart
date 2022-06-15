import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/View/checkout.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:bookstore/widgets/cached.dart';
import 'package:bookstore/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cc=Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           ElevatedButton(onPressed: (){
             Get.to(()=>CheckoutView());
           }, 
           child: Text('Proceed',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)) 
        ],),
      ),
      body: Obx((){
        if(cc.isloading==true){
          return Loader();
        }
        else{
          return cc.items.isEmpty?
          Center(child: Lottie.asset("images/cart.json",),)
          : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cc.items.length,
                  itemBuilder: (context,index){
                    var mydata=cc.items[index];
                    return Card(
                      child: ListTile(
                        leading: CachedImage(imagePath: mydata.item.image),
                        title: Text(mydata.item.name),
                        subtitle: Text("(${mydata.qty}*${mydata.item.sellingPrice})=${mydata.amount}"),  
                        trailing: IconButton(onPressed: () async{
                          SharedPreferences preferences=await SharedPreferences.getInstance();
                          var id=preferences.getString("id");
                          RemoteService.deleteCartItem(mydata.id).whenComplete(() => cc.getcartdetail(int.parse(id.toString())));
                        }, icon: Icon(Icons.delete)),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }
      }),
    );
  }
}