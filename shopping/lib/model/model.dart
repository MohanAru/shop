class Product {
  String? id;
  final String productName;
  final String imageUrl;
  final double vanishRate;
  final double price;
  final String off;
  final double rating;
  final String description;
  final String remarks;

  Product({
    this.id,
    required this.productName,
    required this.imageUrl,
    required this.vanishRate,
    required this.price,
    required this.off,
    required this.rating,
    required this.description,
    required this.remarks,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'productname': productName,
      'imageurl': imageUrl,
      'vanishrate': vanishRate,
      'price': price,
      'off': off,
      'rating': rating,
      'description': description,
      'remarks': remarks,
    };
  }

  // Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      productName: map['productname'] ?? '',
      imageUrl: map['imageurl'] ?? '',
      vanishRate: map['vanishrate']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      off: map['off'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }
}
