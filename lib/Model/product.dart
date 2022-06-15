// To parse required this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
        required this.id,
        required this.categoryId,
        required this.name,
        required this.price,
        required this.discountPercent,
        required this.sellingPrice,
        required this.description,
        required this.image,
    });

    int id;
    int categoryId;
    String name;
    int price;
    int discountPercent;
    int sellingPrice;
    String description;
    String image;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        categoryId: json["categoryId"],
        name: json["name"],
        price: json["price"],
        discountPercent: json["discountPercent"],
        sellingPrice: json["sellingPrice"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "name": name,
        "price": price,
        "discountPercent": discountPercent,
        "sellingPrice": sellingPrice,
        "description": description,
        "image": image,
    };
}
