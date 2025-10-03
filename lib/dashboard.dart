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
  String searchQuery = '';
  List<Product> searchResults = [];
  bool isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  final List<Product> products = [
    Product(
      id: 1,
      name: 'Air Max 97',
      price: 20.99,
      image: 'assets/images/air_max_97.png',
      description: 'Classic Air Max 97 with premium materials and iconic design.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'AM97-001',
      color: 'Yellow/Black',
      country: 'Vietnam',
    ),
    Product(
      id: 2,
      name: 'React Presto',
      price: 25.99,
      image: 'assets/images/react_presto.png',
      description: 'Comfortable React Presto with modern styling.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'RP-102',
      color: 'Red/Blue',
      country: 'China',
    ),
    Product(
      id: 3,
      name: 'Nike Vaporfly 4',
      price: 231.94,
      image: 'assets/images/vaporfly_4.png',
      description: 'High-performance running shoe.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'NV4-203',
      color: 'Blue/White',
      country: 'USA',
    ),
    Product(
      id: 4,
      name: 'Nike Court Vision',
      price: 60.93,
      image: 'assets/images/court_vision.png',
      description: 'Classic basketball-inspired sneaker.',
      sizes: [39, 40, 41, 42, 43, 44],
      style: 'DH3158-101',
      color: 'White/White/Black',
      country: 'India, Vietnam',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> filteredProducts = products.where((product) {
      final matchesCategory = selectedCategory == 'All' || product.name.toLowerCase().contains(selectedCategory.toLowerCase());
      final matchesSearch = searchQuery.isEmpty || product.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

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
                                text: ' Discount',
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
                        const Text('on your first purchase', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                          child: const Text('Shop Now', style: TextStyle(color: Colors.white)),
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
                    child: const Icon(Icons.shopping_bag, size: 40, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    isSearching = value.isNotEmpty;
                    searchResults = products
                        .where((product) => product.name.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for shoes...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Expanded content area
            Expanded(
              child: isSearching
                  ? _buildSearchResults()
                  : _buildProductGrid(filteredProducts),
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
          // BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() => currentIndex = index);
          if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen(cartProvider: cartProvider)));
          } else if (index == 2) {
           Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('No results found', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final product = searchResults[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product, cartProvider: cartProvider),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Category Chips
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
                        onSelected: (_) => setState(() => selectedCategory = category),
                        backgroundColor: Colors.white,
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                          color: selectedCategory == category ? Colors.white : Colors.black,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Product Grid
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(product: product, cartProvider: cartProvider),
                  ),
                ),
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
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
    );
  }
}
