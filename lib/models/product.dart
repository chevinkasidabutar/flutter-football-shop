// Model untuk API endpoint /api/products/
// Format: {id, name, price, description, thumbnail, category, is_featured, ...}

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    int id;
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;
    int stock;
    String color;
    String size;
    int soldCount;
    String? createdAt;
    int? userId;
    String? userUsername;
    int views;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.stock,
        required this.color,
        required this.size,
        required this.soldCount,
        this.createdAt,
        this.userId,
        this.userUsername,
        required this.views,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"] ?? "",
        category: json["category"],
        isFeatured: json["is_featured"],
        stock: json["stock"] ?? 0,
        color: json["color"] ?? "",
        size: json["size"] ?? "",
        soldCount: json["sold_count"] ?? 0,
        createdAt: json["created_at"],
        userId: json["user_id"],
        userUsername: json["user_username"],
        views: json["views"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "color": color,
        "size": size,
        "sold_count": soldCount,
        "created_at": createdAt,
        "user_id": userId,
        "user_username": userUsername,
        "views": views,
    };
}

