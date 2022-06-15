import 'package:bookstore/Model/cart.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  var items=<CartModel>[].obs;
  var isloading=true.obs;

  Future getcartdetail(int id) async{
    try {
      var data=await RemoteService.fetchCartItem(id);
      if(data!=null){
        items.value=data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isloading(false);
    }
  }

 
}