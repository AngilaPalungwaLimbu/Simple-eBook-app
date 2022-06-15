import 'package:bookstore/Controller/cartcontroller.dart';
import 'package:bookstore/Controller/slides_controller.dart';
import 'package:bookstore/View/cart.dart';
import 'package:bookstore/View/pages/homepage.dart';
import 'package:bookstore/View/pages/profile_page.dart';
import 'package:bookstore/View/pages/search_page.dart';
import 'package:bookstore/View/pages/setting_page.dart';
import 'package:bookstore/View/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex=0;
  void navigateBottom(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  final List pages=[
    HomePage(),
    SearchPage(),
    SettingPage(),
    ProfilePage()
  ];

  String? welcomeMessage="My Bookstore";
  getUser() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var id =preferences.getString("id");
    if(id!=null){
      welcomeMessage="Welcome ${preferences.getString("name")}";
      setState(() {
        
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var sc = Get.find<SlidesController>();
    var cc=Get.find<CartController>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()async{
            SharedPreferences preferences=await SharedPreferences.getInstance();
            preferences.remove("id");
            preferences.remove("name");
            preferences.remove("email");
            preferences.remove("password");
            Get.off(()=>SignInView());
          },
          icon: Icon(Icons.exit_to_app),
        ),

        title: Text(
          "$welcomeMessage",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(() => Stack(
           children: [
             IconButton(onPressed: () async{
               SharedPreferences preferences= await SharedPreferences.getInstance();
               var id=preferences.getString("id");
               print('Id is $id');
               if(id!=null){
                cc.getcartdetail(int.parse(id));
                Get.to(()=>CartView());
               }
               else{
                 Get.off(()=>SignInView());
               }
             }, icon: Icon(Icons.shopping_cart_outlined,size: 30,)),
             cc.items.length==0?Text(''): CircleAvatar(child: Text('${cc.items.length}',style: TextStyle(color: Colors.white,fontSize: 12),),backgroundColor: Colors.red,radius: 8,)
           ],
         )
        )
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: navigateBottom,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Setting'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],
      ), 
      
    ));
  }
}

