class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double ?oldprice;
  final String imageUrl;
  final bool isFavorite;
  final String description;
  final int stock;

  const Product({
    required this.id,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    this.oldprice,
    this.isFavorite = false,
    this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      oldprice: (json['oldPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    double? price,
    double? oldprice,
    String? imageUrl,
    bool? isFavorite,
    String? description,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      price: price ?? this.price,
      oldprice: oldprice ?? this.oldprice,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description ?? this.description,
      stock: stock ?? this.stock,
    );
  }
}