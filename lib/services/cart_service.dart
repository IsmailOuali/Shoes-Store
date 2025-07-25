import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';
import '../models/shoe.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  List<CartItem> _cartItems = [];
  List<String> _wishlistIds = [];

  List<CartItem> get cartItems => _cartItems;
  List<String> get wishlistIds => _wishlistIds;
  
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalAmount => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Cart Operations
  void addToCart(Shoe shoe, {String size = '9', String color = 'Black'}) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.id == shoe.name && item.size == size && item.color == color,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(
        id: shoe.name,
        name: shoe.name,
        price: shoe.price,
        imagePath: shoe.imagePath,
        size: size,
        color: color,
      ));
    }
    
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(String itemId, String size, String color) {
    _cartItems.removeWhere(
      (item) => item.id == itemId && item.size == size && item.color == color,
    );
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(String itemId, String size, String color, int quantity) {
    final index = _cartItems.indexWhere(
      (item) => item.id == itemId && item.size == size && item.color == color,
    );
    
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _saveCart();
    notifyListeners();
  }

  // Wishlist Operations
  void toggleWishlist(String shoeId) {
    if (_wishlistIds.contains(shoeId)) {
      _wishlistIds.remove(shoeId);
    } else {
      _wishlistIds.add(shoeId);
    }
    _saveWishlist();
    notifyListeners();
  }

  bool isInWishlist(String shoeId) {
    return _wishlistIds.contains(shoeId);
  }

  // Persistence
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = _cartItems.map((item) => {
      'id': item.id,
      'name': item.name,
      'price': item.price,
      'imagePath': item.imagePath,
      'size': item.size,
      'color': item.color,
      'quantity': item.quantity,
    }).toList();
    await prefs.setString('cart_items', jsonEncode(cartJson));
  }

  Future<void> _saveWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist_ids', _wishlistIds);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load cart
    final cartString = prefs.getString('cart_items');
    if (cartString != null) {
      final cartJson = jsonDecode(cartString) as List;
      _cartItems = cartJson.map((item) => CartItem(
        id: item['id'],
        name: item['name'],
        price: item['price'],
        imagePath: item['imagePath'],
        size: item['size'],
        color: item['color'],
        quantity: item['quantity'],
      )).toList();
    }

    // Load wishlist
    _wishlistIds = prefs.getStringList('wishlist_ids') ?? [];
    
    notifyListeners();
  }
}