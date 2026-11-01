class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String description;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    this.imageUrl,
  });

  // Factory to parse JSON when connecting to ASP.NET Core Web API later
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}