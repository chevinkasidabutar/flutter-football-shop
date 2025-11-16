// To parse this JSON data, do
//
//     final productsEntry = productsEntryFromJson(jsonString);

import 'dart:convert';

List<ProductsEntry> productsEntryFromJson(String str) => List<ProductsEntry>.from(json.decode(str).map((x) => ProductsEntry.fromJson(x)));

String productsEntryToJson(List<ProductsEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsEntry {
    String model;
    int pk;
    Fields fields;

    ProductsEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ProductsEntry.fromJson(Map<String, dynamic> json) => ProductsEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
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
    DateTime createdAt;
    DateTime updatedAt;
    int views;

    Fields({
        required this.user,
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
        required this.createdAt,
        required this.updatedAt,
        required this.views,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        stock: json["stock"],
        color: json["color"],
        size: json["size"],
        soldCount: json["sold_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        views: json["views"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "views": views,
    };
}
