import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  int selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
  });
}