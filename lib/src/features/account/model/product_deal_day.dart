// To parse this JSON data, do
//
//     final dealOfTheDay = dealOfTheDayFromJson(jsonString);

import 'dart:convert';

DealOfTheDayModel dealOfTheDayFromJson(String str) => DealOfTheDayModel.fromJson(json.decode(str));

String dealOfTheDayToJson(DealOfTheDayModel data) => json.encode(data.toJson());

class DealOfTheDayModel {
    DealOfTheDayModel({
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
    List<String> ?images;
    int? quantity;
    int? price;
    String? category;
    List<dynamic>? ratings;
    int? v;

    factory DealOfTheDayModel.fromJson(Map<String, dynamic> json) => DealOfTheDayModel(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
        quantity: json["quantity"] == null ? null : json["quantity"],
        price: json["price"] == null ? null : json["price"],
        category: json["category"] == null ? null : json["category"],
        ratings: json["ratings"] == null ? null : List<dynamic>.from(json["ratings"].map((x) => x)),

        // ratings: json["ratings"] == null ? null : List<dynamic>.from(json["ratings"].map((x) => Rating.fromJson(x))),

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

        // "ratings": ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x.toJson())),

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
