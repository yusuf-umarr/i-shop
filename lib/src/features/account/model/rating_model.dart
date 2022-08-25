import 'dart:convert';

class Rating {
  final String userId;
  final double rating;
  Rating({
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}



// To parse this JSON data, do
//
//     final productRating = productRatingFromJson(jsonString);


// List<ProductRating> productRatingFromJson(String str) => List<ProductRating>.from(json.decode(str).map((x) => ProductRating.fromJson(x)));

// String productRatingToJson(List<ProductRating> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ProductRating {
//     ProductRating({
//         this.userId,
//         this.rating,
     
//     });

//     String? userId;
//     double? rating;


//     factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
//         userId: json["userId"] == null ? null : json["userId"],
//         rating: json["rating"] == null ? null : json["rating"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId == null ? null : userId,
//         "rating": rating == null ? null : rating,
//     };
// }
