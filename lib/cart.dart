import 'package:flutter/material.dart';
import 'models/cart_provider.dart';
import 'confirmation.dart';

class CartScreen extends StatefulWidget {
  final CartProvider cartProvider;

  const CartScreen({Key? key, required this.cartProvider}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Cart Items List
            Expanded(
              child: widget.cartProvider.items.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: widget.cartProvider.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartProvider.items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // Product Image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    item.product.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item.product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Quantity Controls
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (item.quantity > 1) {
                                        setState(() {
                                          widget.cartProvider.updateQuantity(
                                            index,
                                            item.quantity - 1,
                                          );
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove_circle_outline),
                                    iconSize: 24,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.cartProvider.updateQuantity(
                                          index,
                                          item.quantity + 1,
                                        );
                                      });
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                    iconSize: 24,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sub Total :',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${widget.cartProvider.subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee :', style: TextStyle(fontSize: 16)),
                      Text(
                        '\$0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount:', style: TextStyle(fontSize: 16)),
                      Text(
                        '0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${widget.cartProvider.subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: widget.cartProvider.items.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmationScreen(
                                    cartProvider: widget.cartProvider,
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        disabledBackgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Checkout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'models/cart_provider.dart';
// import 'confirmation.dart';

// class CartScreen extends StatefulWidget {
//   final CartProvider cartProvider;

//   const CartScreen({Key? key, required this.cartProvider}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with back button
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back),
//                     style: IconButton.styleFrom(
//                       backgroundColor: Colors.grey[200],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Text(
//                     'Cart',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Cart Items List
//             Expanded(
//               child: widget.cartProvider.items.isEmpty
//                   ? const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.shopping_cart_outlined,
//                             size: 80,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(height: 16),
//                           Text(
//                             'Your cart is empty',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: widget.cartProvider.items.length,
//                       itemBuilder: (context, index) {
//                         final item = widget.cartProvider.items[index];
//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 16),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               // Product Image
//                               Container(
//                                 width: 80,
//                                 height: 80,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Center(
//                                   child: Image.asset(
//                                     item.product.image,
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.contain,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return const Icon(
//                                         Icons.image_not_supported,
//                                         size: 40,
//                                         color: Colors.grey,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),

//                               // Product Details + Size Selector
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       item.product.name,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       '\$${item.product.price.toStringAsFixed(2)}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),

//                                     // Size selector dropdown
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           'Size: ',
//                                           style: TextStyle(fontSize: 14),
//                                         ),
//                                         DropdownButton<int>(
//                                           value: item.selectedSize,
//                                           items: [6, 7, 8, 9, 10, 11, 12]
//                                               .map((size) => DropdownMenuItem(
//                                                     value: size,
//                                                     child: Text(size.toString()),
//                                                   ))
//                                               .toList(),
//                                           onChanged: (newSize) {
//                                             if (newSize != null) {
//                                               setState(() {
//                                                 widget.cartProvider.updateSize(
//                                                   index,
//                                                   newSize,
//                                                 );
//                                               });
//                                             }
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // Quantity Controls
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       if (item.quantity > 1) {
//                                         setState(() {
//                                           widget.cartProvider.updateQuantity(
//                                             index,
//                                             item.quantity - 1,
//                                           );
//                                         });
//                                       }
//                                     },
//                                     icon: const Icon(Icons.remove_circle_outline),
//                                     iconSize: 24,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 12,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: Text(
//                                       item.quantity.toString(),
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         widget.cartProvider.updateQuantity(
//                                           index,
//                                           item.quantity + 1,
//                                         );
//                                       });
//                                     },
//                                     icon: const Icon(Icons.add_circle_outline),
//                                     iconSize: 24,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//             ),

//             // Order Summary
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Sub Total :',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         '\$${widget.cartProvider.subtotal.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Delivery Fee :', style: TextStyle(fontSize: 16)),
//                       Text(
//                         '\$0',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Discount:', style: TextStyle(fontSize: 16)),
//                       Text(
//                         '0',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(height: 24, thickness: 1),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text(
//                         '\$${widget.cartProvider.subtotal.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: widget.cartProvider.items.isEmpty
//                           ? null
//                           : () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ConfirmationScreen(
//                                     cartProvider: widget.cartProvider,
//                                   ),
//                                 ),
//                               );
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         disabledBackgroundColor: Colors.grey[400],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.shopping_cart, color: Colors.white),
//                           SizedBox(width: 8),
//                           Text(
//                             'Checkout',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
