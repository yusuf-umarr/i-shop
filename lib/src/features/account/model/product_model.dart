import 'dart:convert';

import 'package:i_shop/src/features/account/model/rating_model.dart';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}















List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
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

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
