import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}


// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.token,
        this.id,
        this.name,
        this.email,
        this.password,
        this.address,
        this.type,
        this.cart,
        this.v,
    });

    String? token;
    String? id;
    String? name;
    String? email;
    String? password;
    String? address;
    String? type;
    List<Cart>? cart;
    int? v;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"] == null ? null : json["token"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        address: json["address"] == null ? null : json["address"],
        type: json["type"] == null ? null : json["type"],
        cart: json["cart"] == null ? null : List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "address": address == null ? null : address,
        "type": type == null ? null : type,
        "cart": cart == null ? null : List<dynamic>.from(cart!.map((x) => x.toJson())),
        "__v": v == null ? null : v,
    };
}

class Cart {
    Cart({
        this.product,
        this.quantity,
        this.id,
    });

    Product? product;
    int? quantity;
    String? id;

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"] == null ? null : json["quantity"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "quantity": quantity == null ? null : quantity,
        "_id": id == null ? null : id,
    };
}

class Product {
    Product({
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

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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

