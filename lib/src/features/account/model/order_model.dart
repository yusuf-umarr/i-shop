import 'dart:convert';

import 'package:i_shop/src/features/account/model/product_model.dart';


class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}


// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);


List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    OrderModel({
        this.id,
        this.products,
        this.totalPrice,
        this.address,
        this.userId,
        this.orderedAt,
        this.status,
        this.v,
    });

    String? id;
    List<dynamic>? products;
    int? totalPrice;
    String? address;
    String? userId;
    int? orderedAt;
    int? status;
    int? v;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"] == null ? null : json["_id"],
        products: json["products"] == null ? null : List<dynamic>.from(json["products"].map((x) => x)),
        totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
        address: json["address"] == null ? null : json["address"],
        userId: json["userId"] == null ? null : json["userId"],
        orderedAt: json["orderedAt"] == null ? null : json["orderedAt"],
        status: json["status"] == null ? null : json["status"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalPrice": totalPrice == null ? null : totalPrice,
        "address": address == null ? null : address,
        "userId": userId == null ? null : userId,
        "orderedAt": orderedAt == null ? null : orderedAt,
        "status": status == null ? null : status,
        "__v": v == null ? null : v,
    };
}

class ProductElement {
    ProductElement({
        this.product,
        this.quantity,
        this.id,
    });

    ProductProduct? product;
    int? quantity;
    String
    ? id;

    factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"] == null ? null : json["quantity"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "quantity": quantity == null ? null : quantity,
        "_id": id == null ? null : id,
    };
}

class ProductProduct {
    ProductProduct({
        this.name,
        this.description,
        this.images,
        this.quantity,
        this.price,
        this.category,
        this.ratings,
        this.id,
        this.v,
    });

    String? name;
    String? description;
    List<String>? images;
    int? quantity;
    int? price;
    String? category;
    List<Rating>? ratings;
    String? id;
    int? v;

    factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        category: json["category"] == null ? null : json["category"],
        ratings: json["ratings"] == null ? null : List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
        id: json["_id"] == null ? null : json["_id"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity == null ? null : quantity,
        "price": price == null ? null : price,
        "category": category == null ? null : category,
        "ratings": ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "_id": id == null ? null : id,
        "__v": v == null ? null : v,
    };
}

class Rating {
    Rating({
        this.userId,
        this.rating,
        this.id,
    });

    String? userId;
    int? rating;
    String? id;

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        userId: json["userId"] == null ? null : json["userId"],
        rating: json["rating"] == null ? null : json["rating"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "rating": rating == null ? null : rating,
        "_id": id == null ? null : id,
    };
}
