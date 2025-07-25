class Shoe {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final String category;

  Shoe({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    this.sizes = const ['7', '7.5', '8', '8.5', '9', '9.5', '10', '10.5', '11'],
    this.colors = const ['Black', 'White', 'Red'],
    this.rating = 4.5,
    this.reviewCount = 128,
    this.isFavorite = false,
    this.category = 'Sneakers',
  });

  // Convert price string to double for calculations
  double get priceValue {
    return double.tryParse(price.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
  }

  // Create a copy with modified properties
  Shoe copyWith({
    String? name,
    String? price,
    String? imagePath,
    String? description,
    List<String>? sizes,
    List<String>? colors,
    double? rating,
    int? reviewCount,
    bool? isFavorite,
    String? category,
  }) {
    return Shoe(
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
    );
  }
}