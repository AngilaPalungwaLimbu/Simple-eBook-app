import 'package:bookstore/Model/product.dart';
import 'package:bookstore/Model/product_detail.dart';
import 'package:bookstore/services/remote_service.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController{
  var product=ProductDetailModel(id: 1, categoryId: 1, name: '', price: 1, discountPercent: 1, sellingPrice: 1, description: "", image: "").obs;
  var isloading=true.obs;

  Future getproductdetail(int id) async{
    try {
      var data=await RemoteService.fetchProductDetail(id);
      if(data!=null){
        product.value=data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      isloading(false);
    }
  }

 
}