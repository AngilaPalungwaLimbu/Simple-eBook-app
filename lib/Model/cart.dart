// To parse required this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
    CartModel({
        required this.itemId,
        required this.qty,
        required this.amount,
        required this.userId,
        required this.id,
        required this.item,
    });

    int itemId;
    int qty;
    int amount;
    int userId;
    int id;
    Item item;

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        itemId: json["itemId"],
        qty: json["qty"],
        amount: json["amount"],
        userId: json["userId"],
        id: json["id"],
        item: Item.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "qty": qty,
        "amount": amount,
        "userId": userId,
        "id": id,
        "item": item.toJson(),
    };
}

class Item {
    Item({
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

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
