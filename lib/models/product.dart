class Product {
  final int id;
  final String title;
  final num price;
  final String category;
  final String description;
  final String image;
  // final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    // required this.rating
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      title: json['title'] ?? "",
      price: json['price'] ?? 0.0,
      category: json['category'] ?? "",
      description: json['description'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
