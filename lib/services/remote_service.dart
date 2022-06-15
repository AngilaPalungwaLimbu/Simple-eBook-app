import 'dart:convert';
import 'package:bookstore/Model/cart.dart';
import 'package:bookstore/Model/product.dart';
import 'package:bookstore/Model/product_detail.dart';
import 'package:bookstore/Model/slide.dart';
import 'package:bookstore/View/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteService {
  static var client = http.Client();
  static var baseURL = 'http://192.168.1.149:3000';
  static Future<List<String>?> fetchSlides() async {
    try {
      var response = await client.get(Uri.parse('$baseURL/slides'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return slideModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future<List<ProductModel>?> fetchProduct() async {
    try {
      var response = await client.get(Uri.parse('$baseURL/items'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return productModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // fetch Product Detail
  static Future<ProductDetailModel?> fetchProductDetail(int id) async {
    try {
      var response = await client.get(Uri.parse('$baseURL/items/$id'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return productDetailModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // post add to cart
  static Future addToCart(Map mapData) async {
    try {
      var response = await client.post(Uri.parse('$baseURL/cart'),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(mapData));
      if (response.statusCode == 201) {
        Get.snackbar('Success ', 'Items Added to Cart',
            snackPosition: SnackPosition.BOTTOM);
      }
      ;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // fetch Cart Item
  static Future<List<CartModel>?> fetchCartItem(int id) async {
    try {
      var response =
          await client.get(Uri.parse('$baseURL/cart?userId=$id&_expand=item'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return cartModelFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      Get.snackbar("Err", e.toString());
    }
  }

  // Delete Cart Item
  static Future deleteCartItem(int id) async {
    try {
      var response = await client.delete(Uri.parse('$baseURL/cart/$id'));
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Item deleted",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  static Future login(String email, String password) async {
    try {
      SharedPreferences preferences=await SharedPreferences.getInstance();
      var response = await client.get(Uri.parse('$baseURL/users?email=$email&password=$password'));
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      print(jsonData.length);
      if(jsonData.length>0){
        // login
         preferences.setString("id", jsonData[0]["id"].toString());
         preferences.setString("name", jsonData[0]["name"].toString());
         preferences.setString("email", jsonData[0]["email"].toString());
         preferences.setString("password", jsonData[0]["password"].toString());
        Get.off(()=>HomeView());
      }
      else{
        Get.snackbar("Error","Invalid User Input");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // place order
  static Future placeOrder(Map data) async{
    try {
      var response=await client.post(Uri.parse("$baseURL/orders"),headers: {"Accept":"application/json","Content-type":"application/json"},body: jsonEncode(data));
      if(response.statusCode==201){
        Get.defaultDialog(
          content: Text("Your Order has been placed"),
          actions: [
            ElevatedButton(onPressed: (){
              Get.off(()=>HomeView());
            }, 
            child: Text("Continue"))
          ]
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
