import 'package:bookstore/Model/product.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var products=<ProductModel>[].obs;
  var isloading=true.obs;

  Future getproduct() async{
    try {
      var data=await RemoteService.fetchProduct();
      if(data!=null){
        products.value=data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isloading(false);
    }
  }

  @override
  void onInit() {
    
    super.onInit();
    getproduct();
  }
}