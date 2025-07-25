import 'package:flutter/material.dart';

import 'shoe.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoes = [
    Shoe(
      name: 'Shoe 1',
      price: '20',
      imagePath: 'lib/images/Air1.jfif',
      description: 'Description of Shoe 1',
    ),
    Shoe(
      name: 'Shoe 2',
      price: '30',
      imagePath: 'lib/images/Air2.jfif',
      description: 'Description of Shoe 2',
    ),
    Shoe(
      name: 'Shoe 3',
      price: '40',
      imagePath: 'lib/images/Air3.jfif',
      description: 'Description of Shoe 3',
    ),
    Shoe(
      name: 'Shoe 4',
      price: '50',
      imagePath: 'lib/images/Air4.jfif',
      description: 'Description of Shoe 4',
    ),
    Shoe(
      name: 'Shoe 5',
      price: '60',
      imagePath: 'lib/images/Air5.jfif',
      description: 'Description of Shoe 5',
    ),

    
  ];

  List<Shoe> useCart = [];

  List<Shoe> getShoeList() {
    return shoes;
  }

  List<Shoe> getUserCart() {
    return useCart;
  }

  void addItemToCart(Shoe shoe) {
    useCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    useCart.remove(shoe);
    notifyListeners();
  }
}