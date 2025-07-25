class Shoe {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  final String category;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final List<String> colors;

  Shoe({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.sizes = const ['7', '7.5', '8', '8.5', '9', '9.5', '10', '10.5', '11', '11.5', '12'],
    this.colors = const ['Black', 'White', 'Red', 'Blue', 'Gray'],
  });
}