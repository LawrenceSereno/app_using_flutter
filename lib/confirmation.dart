import 'package:flutter/material.dart';
import 'models/cart_provider.dart';
import 'dashboard.dart';

class ConfirmationScreen extends StatelessWidget {
  final CartProvider cartProvider;

  const ConfirmationScreen({Key? key, required this.cartProvider})
      : super(key: key);

  void _clearCartAndNavigate(BuildContext context, RoutePredicate predicate) {
    cartProvider.clearCart();
    Navigator.of(context).popUntil(predicate);
  }


  void btnt(BuildContext context) {
   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DashboardScreen() //HomePage(
      //username: enteredText,
      //password: passwordText,
    //),
  ),
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
              const SizedBox(height: 48),

              // Buttons
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize:const Size(20, 50),
              ),
              onPressed: () => btnt(context),
              child: const Text('Go to Dashboard'),
            ),
            // const SizedBox(height: 20),
            //   const SizedBox(height: 16),
            //   SizedBox(
            //     width: double.infinity,
            //     child: OutlinedButton(
            //       onPressed: () {
            //         // Clear cart and go back to shop (assumed to be first route)
            //         _clearCartAndNavigate(context, (route) => route.isFirst);
            //       },
            //       style: OutlinedButton.styleFrom(
            //         padding: const EdgeInsets.symmetric(vertical: 16),
            //         side: const BorderSide(color: Colors.white),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //       child: const Text(
            //         'Back to Shop',
            //         style: TextStyle(fontSize: 18, color: Colors.white),
            //       ),
            //     ),
            //   ),
            ],
          ),
        ),
      ),
    );
  }
}
