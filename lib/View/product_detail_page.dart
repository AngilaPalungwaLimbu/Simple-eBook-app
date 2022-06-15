import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/Controller/product_detail.dart';
import 'package:bookstore/View/cart.dart';
import 'package:bookstore/View/sign_in.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:bookstore/util/app_color.dart';
import 'package:bookstore/widgets/loader.dart';
import 'package:bookstore/widgets/my_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var pdc = Get.find<ProductDetailController>();
    var ccc=Get.find<CartController>();

  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
          actions: [
          Obx(() => Stack(
           children: [
             IconButton(onPressed: ()async{
                SharedPreferences preferences= await SharedPreferences.getInstance();
               var id=preferences.getString("id");
               if(id!=null){
                ccc.getcartdetail(int.parse(id));
                Get.to(()=>CartView());
               }
               else{
                 Get.off(()=>SignInView());
               }
             }, icon: const Icon(Icons.shopping_cart_outlined,size: 30,)),
             ccc.items.length==0?const Text(''): CircleAvatar(child: Text('${ccc.items.length}',style: const TextStyle(color: Colors.white,fontSize: 12),),backgroundColor: Colors.red,radius: 8,)
           ],
         )
        )
        ],
        ),
        body: Obx(() {
          if (pdc.isloading == true) {
            return const Loader();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      height: Get.size.height * 0.4,
                      width: Get.size.width,
                      padding: EdgeInsets.symmetric(
                        vertical: Get.size.height * 0.02,
                      ),
                      child: CachedNetworkImage(
                          imageUrl: pdc.product.value.image)),
                  SizedBox(
                    height: Get.size.height * 0.025,
                  ),
                  ListTile(
                    title: Text(
                      pdc.product.value.name,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Rs.${pdc.product.value.sellingPrice}  ',
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.black),
                                  ),
                                  pdc.product.value.discountPercent > 0
                                      ? Text(
                                          'Rs.${pdc.product.value.price}',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (qty <= 1) {
                                        qty = 1;
                                      } else {
                                        qty--;
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: AppColor.pColor,
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    color: Colors.grey.shade200,
                                    child: Center(
                                        child: Text(
                                      '$qty',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      qty++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      color: AppColor.pColor,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Description',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        ReadMoreText(
                          pdc.product.value.description,
                          style: TextStyle(color: Colors.grey.shade700),
                          trimLines: 3,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: MyButton(
                              btnText: 'Add to Cart',
                              onPressed: () async{
                                SharedPreferences preferences=await SharedPreferences.getInstance();
                                var id=preferences.getString("id");
                                Map data = {
                                  "itemId": pdc.product.value.id,
                                  "qty": qty,
                                  "amount": pdc.product.value.sellingPrice*qty,
                                  "userId": int.parse(id.toString()),
                                };
                                if(id!=null){
                                RemoteService.addToCart(data).whenComplete(() => ccc.getcartdetail(int.parse(id))); 
                                }
                                else {
                                  Get.off(()=>SignInView());
                                }
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
