import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login.dart';
import 'dashboard.dart';
import 'product_detail.dart';
import 'cart.dart';
import 'profile.dart';
import 'search.dart';
import 'models/product.dart';
import 'models/cart_provider.dart';

void main() {
  runApp(const ShoeStoreApp());
}

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
