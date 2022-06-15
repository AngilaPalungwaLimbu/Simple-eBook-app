import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/Controller/product.dart';
import 'package:bookstore/Controller/product_detail.dart';
import 'package:bookstore/Controller/slides_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SlidesController());
    Get.put(ProductController());
    Get.put(ProductDetailController());
    Get.put(CartController());
  }

}