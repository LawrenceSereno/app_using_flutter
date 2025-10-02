import 'package:flutter/material.dart';
import 'models/product.dart';
import 'product_detail.dart';
import 'models/cart_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CartProvider cartProvider = CartProvider();
  List<Product> searchResults = [];
  bool isSearching = false;

  final List<Product> allProducts = [
    Product(
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

  void _performSearch(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _performSearch,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Search Results
            Expanded(
              child: !isSearching
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Search for shoes',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : searchResults.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No results found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final product = searchResults[index];
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
                                      child: Center(
                                        child: Image.asset(
                                          product.image,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.image_not_supported,
                                              size: 40,
                                              color: Colors.grey,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '\${product.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios, size: 16),
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
    );
  }
}
