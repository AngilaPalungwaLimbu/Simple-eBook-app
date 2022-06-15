import 'package:bookstore/Controller/product.dart';
import 'package:bookstore/Controller/product_detail.dart';
import 'package:bookstore/Controller/slides_controller.dart';
import 'package:bookstore/View/product_detail_page.dart';
import 'package:bookstore/widgets/cached.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sc = Get.find<SlidesController>();
    var pc=Get.find<ProductController>();
    var pdc=Get.find<ProductDetailController>();
    return SafeArea(
        child: Scaffold(
      
      
      body: Obx(() {
        if (sc.isloading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(children: [
              Container(
                height: Get.size.height * 0.28,
                child: CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1, autoPlay: true, height: 400.0),
                  items: sc.slides.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: Get.size.width,
                          child: CachedImage(imagePath: i),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                title: Text('Best Sellers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Container(
                width: Get.size.width,
                height: Get.size.height*0.37,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: pc.products.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: InkWell(
                        onTap: () {
                          pdc.getproductdetail(pc.products[index].id).whenComplete(() => Get.to(()=>ProductDetailPage())); 
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: Get.size.height*0.8,
                                  width: Get.size.width*0.4,
                                  child:CachedImage(imagePath: pc.products[index].image,)),
                              ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(pc.products[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                               Row(
                                 children: [
                                   Text('Rs.${pc.products[index].sellingPrice}'),
                                   SizedBox(width: 20,),
                                   pc.products[index].discountPercent>0?
                                   Text('Rs.${pc.products[index].price}',style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough),):SizedBox()
                                 ],
                               )
                                 ],
                               ),
                             )
                              
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          );
        }
      }),
    ));
  }
}

