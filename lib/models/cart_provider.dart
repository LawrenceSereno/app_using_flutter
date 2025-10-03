// import 'package:flutter/foundation.dart';
// import 'product.dart';
// import 'cart_item.dart';

// class CartProvider extends ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   double get subtotal {
//     return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
//   }

//   void addItem(Product product, int size) {
//     _items.add(CartItem(product: product, selectedSize: size));
//     notifyListeners();
//   }

//   void removeItem(int index) {
//     _items.removeAt(index);
//     notifyListeners();
//   }

// void updateSize(int index, int newSize) {
//   _items[index].selectedSize = newSize;
//   notifyListeners();
// }

//   void updateQuantity(int index, int quantity) {
//     if (quantity > 0) {
//       _items[index].quantity = quantity;
//       notifyListeners();
//     }
//   }

//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
// }

import 'package:flutter/foundation.dart';
import 'product.dart';
import 'cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  // Add item with size check
  void addItem(Product product, int size) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size,
    );

    if (index != -1) {
      // Product with same size exists, update quantity
      _items[index].quantity += 1;
    } else {
      // New item with size
      _items.add(CartItem(product: product, selectedSize: size));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  // Update the shoe size for an existing cart item
  void updateSize(int index, int newSize) {
    _items[index].selectedSize = newSize;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
