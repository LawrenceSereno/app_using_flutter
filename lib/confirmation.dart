import 'package:flutter/material.dart';
import 'models/cart_provider.dart';

class ConfirmationScreen extends StatelessWidget {
  final CartProvider cartProvider;

  const ConfirmationScreen({Key? key, required this.cartProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Clear cart and navigate back to home after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        cartProvider.clearCart();
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Order is on the way....',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 60,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}