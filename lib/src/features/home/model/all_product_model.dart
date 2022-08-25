// To parse this JSON data, do
//
//     final allProductResponseModel = allProductResponseModelFromJson(jsonString);

import 'dart:convert';

List<AllProductResponseModel> allProductResponseModelFromJson(String str) => List<AllProductResponseModel>.from(json.decode(str).map((x) => AllProductResponseModel.fromJson(x)));

String allProductResponseModelToJson(List<AllProductResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProductResponseModel {
    AllProductResponseModel({
        this.id,
        this.name,
        this.description,
        this.images,
        this.quantity,
        this.price,
        this.category,
        this.ratings,
        this.v,
    });

    String? id;
    String? name;
    String? description;
    List<String>? images;
    int? quantity;
    int? price;
    String? category;
    List<dynamic>? ratings;
    int? v;

    factory AllProductResponseModel.fromJson(Map<String, dynamic> json) => AllProductResponseModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        category: json["category"] == null ? null : json["category"],
        ratings: json["ratings"] == null ? null : List<dynamic>.from(json["ratings"].map((x) => x)),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "category": category == null ? null : category,
        "ratings": ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x)),
        "__v": v == null ? null : v,
    };
}
