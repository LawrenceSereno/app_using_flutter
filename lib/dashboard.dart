import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'cart.dart';
import 'profile.dart';
import 'search.dart';
import 'models/product.dart';
import 'models/cart_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CartProvider cartProvider = CartProvider();
  String selectedCategory = 'All';
  int currentIndex = 0;

  final List<Product> products = [
    Product(
      name: 'Air Max 97',
      price: 20.99,
      image: 'assets/images/air_max_97.png',
      description: 'Classic Air Max 97 with premium materials and iconic design. Features visible Air cushioning and retro styling.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'AM97-001',
      color: 'Yellow/Black',
      country: 'Vietnam',
    ),
    Product(
      name: 'React Presto',
      price: 25.99,
      image: 'assets/images/react_presto.png',
      description: 'Comfortable React Presto with modern styling and cushioning. Perfect for everyday wear with responsive foam.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'RP-102',
      color: 'Red/Blue',
      country: 'China',
    ),
    Product(
      name: 'Nike Vaporfly 4',
      price: 231.94,
      image: 'assets/images/vaporfly_4.png',
      description: 'High-performance running shoe with carbon fiber plate. Designed for serious runners seeking maximum speed.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'NV4-203',
      color: 'Blue/White',
      country: 'USA',
    ),
    Product(
      name: 'Nike Court Vision',
      price: 60.93,
      image: 'assets/images/court_vision.png',
      description: 'In love with the classic look of \'80s basketball but have a thing for the fast-paced culture of today\'s game? Meet the Nike Court Vision Low. A crispy upper and stitched overlays keep the soul of the original style. Its padded collar and rubber outsole bring comfort and traction for your world.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'DH3158-101',
      color: 'White/White/Black',
      country: 'India, Vietnam',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Banner
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '20%',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Discount',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'on your first purchase',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'Shop Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.teal[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['All', 'Running', 'Sneakers', 'Formal', 'Casual']
                    .map((category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            backgroundColor: Colors.white,
                            selectedColor: Colors.black,
                            labelStyle: TextStyle(
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Products Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            product: product,
                            cartProvider: cartProvider,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  product.image,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported,
                                      size: 60,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward, size: 20),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          if (index == 1) {
            // Search
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          } else if (index == 2) {
            // Cart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(cartProvider: cartProvider),
              ),
            );
          } else if (index == 3) {
            // Profile
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
