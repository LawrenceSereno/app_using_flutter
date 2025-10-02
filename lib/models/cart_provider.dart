import 'package:flutter/foundation.dart';
import 'product.dart';
import 'cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addItem(Product product, int size) {
    _items.add(CartItem(product: product, selectedSize: size));
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

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}