class CartItem {
  final String id;
  final String name;
  final String price;
  final String imagePath;
  final String size;
  final String color;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.size,
    required this.color,
    this.quantity = 1,
  });

  double get totalPrice {
    final priceValue = double.tryParse(price.replaceAll('\$', '').replaceAll(',', '')) ?? 0.0;
    return priceValue * quantity;
  }

  CartItem copyWith({
    String? id,
    String? name,
    String? price,
    String? imagePath,
    String? size,
    String? color,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
    );
  }
}