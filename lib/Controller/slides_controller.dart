import 'package:bookstore/services/remote_service.dart';
import 'package:get/get.dart';

class SlidesController extends GetxController{
  var slides=<String>[].obs;
  var isloading=true.obs;

  Future getslides() async{
    try {
      var data=await RemoteService.fetchSlides();
      if(data!=null){
        slides.value=data;
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
    getslides();
  }
}