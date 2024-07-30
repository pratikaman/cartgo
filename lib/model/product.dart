// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


/// Product represents a product in the store.
class Product {
  const Product({
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
  });

  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final String thumbnail;


  Product copyWith({
    String? title,
    String? description,
    double? price,
    double? discountPercentage,
    String? thumbnail,
  }) {
    return Product(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      discountPercentage: (map['discountPercentage'] as num).toDouble(),
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(title: $title, description: $description, price: $price, discountPercentage: $discountPercentage, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.price == price &&
      other.discountPercentage == discountPercentage &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      discountPercentage.hashCode ^
      thumbnail.hashCode;
  }
}
