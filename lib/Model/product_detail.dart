// To parse required this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
    ProductDetailModel({
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

    factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
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
